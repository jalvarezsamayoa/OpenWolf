# -*- coding: utf-8 -*-
require 'rubygems'
require 'fastercsv'

class Herramienta
  attr_reader :institucion
  ESTADO_ENTRAMITE = 1
  ESTADO_NOEXISTE = 0
  ESTADO_PRORROGA = 2
  ESTADO_ENTREGA_TOTAL = 3
  ESTADO_ENTREGA_PARCIAL = 4
  ESTADO_DENEGADA = 5
  ESTADO_DESECHADA = 6
  ESTADO_NO_RECOGIDA = 7

  ESTADO_ACTIVIDAD_EN_TRAMITE = 1
  ESTADO_ACTIVIDAD_TERMINADA = 2

  RESOLUCION_PRORROGA = true

  attr_accessor :institucion, :enlace, :clasificacion, :clasificacion_resolucion
  
  def initialize
    self.institucion = nil
    self.enlace = nil
    self.clasificacion = Documentoclasificacion.find_by_codigo(Documentoclasificacion::SOLICITUDINFOPUBLICA).id
    self.clasificacion_resolucion = Documentoclasificacion.find_by_codigo(Documentoclasificacion::RESOLUCION).id
  end

  # :path Archivo csv con la informacion
  # :institucion_id Id de institucio hacia donde se importan los datos
  # :usuario_id Id de usuario que importa datos
  def importar_solicitudes(options)
    file = options[:file]
    campos = options[:campos]
    usuario_id = options[:usuario_id]

    WorkerLog.clear

    #importamos registros a la tabla
    WorkerLog.log("Leyendo archivo CSV...")

    #obtenemos documento
    csv_doc = FasterCSV.new(options[:file].read, {:headers => true, :encoding => 'utf8', :skip_blanks => true})
    WorkerLog.log("Importando informacion archivo CSV...")

    self.institucion = preparar_institucion(options[:institucion_id])
  
    # agregar enlaces
    # usar por default el usuario jefe de la unidad de informacion
    self.enlace = institucion.usuarios.activos.supervisores.first

    self.importar_registros(csv_doc, campos, usuario_id, self.institucion, self.enlace)

  end


  #importa los registros enviados
  def importar_registros(csv_doc, campos, usuario_id, institucion, enlace)

    linea = 0

    WorkerLog.log("Leyendo CSV...")

    #barremos lineas de documento
    csv_doc.each do |row|
      linea += 1
      WorkerLog.log("Importando Linea #{linea}")

      unless importar_solicitud(row, campos, usuario_id, institucion, enlace)
        WorkerLog.error("Error al importar linea #{linea}")
        break
      end

    end #csv_doc.each
    csv_doc.close

  end #importar_registros

  #busca institucion y borra todas sus solicitudes relacionadas
  def preparar_institucion(institucion_id)
    WorkerLog.log("Buscando Institucion #{institucion_id}")
    institucion = Institucion.find(institucion_id)
    WorkerLog.log("Borrar Solicitudes")
    institucion.solicitudes.clear

    return institucion
  end


  # genera una solicitud a partir de un row del archivo csv
  def importar_solicitud(row, campos, usuario_id, institucion, enlace)
    WorkerLog.log("Importando solicitud")
    lok = false

    return false unless tiene_informacion_minima?(row, campos)

    #verificamos el estado de la solicitud a importar
    estado_solicitud = obtener_estado_solicitud(row, campos)

    return false if estado_solicitud == 0

    case estado_solicitud
    when ESTADO_ENTRAMITE
      lok = crear_solicitud_en_tramite(row, campos, estado_solicitud, institucion, enlace)
    when ESTADO_PRORROGA
      lok = crear_solicitud_con_prorroga(row, campos, estado_solicitud, institucion, enlace)
    when ESTADO_ENTREGA_TOTAL
      lok = crear_solicitud_entregada_total(row, campos, estado_solicitud, institucion, enlace)
    when ESTADO_ENTREGA_PARCIAL
      lok = crear_solicitud_entregada_parcial(row, campos, estado_solicitud, institucion, enlace)
    when ESTADO_DENEGADA
      lok = crear_solicitud_denegada(row, campos, estado_solicitud, institucion, enlace)
    when ESTADO_DESECHADA
      lok = crear_solicitud_desechada(row, campos, estado_solicitud, institucion, enlace)
    when ESTADO_NO_RECOGIDA
      lok = crear_solicitud_no_recogida(row, campos, estado_solicitud, institucion, enlace)
    end

    return lok
  end #importar_solicitud


  def tiene_informacion_minima?(row, campos)
    WorkerLog.log("Informacion minima?")
    # no tomamos en cuenta solicitudes sin texto
    return false if row[campos['solicitud']].nil? or row[campos['solicitud']].empty?
    WorkerLog.log("Informacion minima... Ok")
    return true
  end

  #obtiene y verifica el estado de la solicitud a importar
  def obtener_estado_solicitud(row, campos)
    WorkerLog.log("Obteniendo estado solicitud...")

    #limpiamos el texto del campo
    c_estatus = row[campos['estatus']]

    #si no existe valor en el campo se toma como solicitud no asignada
    return ESTADO_ENTRAMITE if (c_estatus.nil? or c_estatus.empty?)

    c_estatus = c_estatus.strip

    c_estatus = c_estatus.tr_s('á','Á')
    c_estatus = c_estatus.tr_s('é','É')
    c_estatus = c_estatus.tr_s('í','Í')
    c_estatus = c_estatus.tr_s('ó','Ó')
    c_estatus = c_estatus.tr_s('ú','Ú')

    c_estatus = c_estatus.upcase

    #buscamos el código del estado
    estado = Estado.where("upper(nombre) = ?", c_estatus).first

    if estado.nil?
      WorkerLog.error("Estado no encontrado: #{c_estatus}")
    else
      WorkerLog.log("Estado: #{estado.nombre}")
    end

    return ESTADO_NOEXISTE if estado.nil?

    return estado.id
  end

  def crear_solicitud_en_tramite(row, campos, estado_solicitud, institucion, enlace)
    WorkerLog.log("Creando solicitud en tramite.")

    valores = extraer_valores(row,campos)
    solicitud = crear_solicitud(valores,ESTADO_ENTRAMITE)

    return false unless solicitud

    asignar_a_enlace(solicitud, ESTADO_ACTIVIDAD_EN_TRAMITE)
  end

  def crear_solicitud_entregada_total(row, campos, estado_solicitud, institucion, enlace)
    logger.debug { "Creado solicitud entregada total." }
    crear_solicitud_entregada(row,campos,ESTADO_ENTREGA_TOTAL)
    return true
  end

  def crear_solicitud_entregada_parcial(row, campos, estado_solicitud, institucion, enlace)
    logger.debug { "Creado solicitud entregada parcial." }
    crear_solicitud_entregada(row,campos,ESTADO_ENTREGA_PARCIAL)
    return true
  end

  def crear_solicitud_denegada(row, campos, estado_solicitud, institucion, enlace)
    logger.debug { "Creado solicitud denegada." }
    crear_solicitud_entregada(row,campos,ESTADO_DENEGADA)
    return true
  end

  def crear_solicitud_entregada(row,campos,estado_solicitud)
    valores = extraer_valores(row,campos)
    solicitud = crear_solicitud(valores,estado_solicitud)
    return false unless solicitud
    actividad = asignar_a_enlace(solicitud, ESTADO_ACTIVIDAD_TERMINADA)
    agregar_seguimiento(solicitud, actividad)
    agregar_resolucion(solicitud)
  end


  def crear_solicitud_con_prorroga(row, campos, estado_solicitud, institucion, enlace)
    logger.debug { "Creado solicitud con prorroga." }
    valores = extraer_valores(row,campos)
    solicitud = crear_solicitud(valores,estado_solicitud)
    return false unless solicitud
    actividad = asignar_a_enlace(solicitud, ESTADO_ACTIVIDAD_TERMINADA)
    agregar_seguimiento(solicitud, actividad)
    agregar_resolucion(solicitud, RESOLUCION_PRORROGA)
    return true
  end

  def crear_solicitud_desechada(row, campos, estado_solicitud, institucion, enlace)
    logger.debug { "Creado solicitud en desechada." }
    crear_solicitud_entregada(row,campos,ESTADO_DESECHADA)
    return true
  end

  def crear_solicitud_no_recogida(row, campos, estado_solicitud, institucion, enlace)
    logger.debug { "Creado solicitud no recogida." }
    crear_solicitud_entregada(row,campos,ESTADO_DESECHADA)
    return true
  end

  def crear_solicitud(valores, estado_id)

    e = Estado.find(estado_id)
    valores[:estado_id] = e.id

    # la fecha programada de entrega SIEMPRE SON 10 DIAS POR LEY
    # solo se modifica si hay prorroga
    valores[:fecha_programada] = valores[:fecha_creacion] + 14

    # si no se encuentra en un estado final todas las fechas son NIL
    unless e.final?
      valores[:fecha_entregada] = nil
      valores[:fecha_completada] = nil
    end

    s = Solicitud.new(valores)
    s.save!
    return s

  end

  def asignar_a_enlace(solicitud, actividad_estado_id = 1)
    logger.debug { "Asignando a enlace" }

    #assigar enalces / actividades
    actividad = Actividad.new(:solicitud_id => solicitud.id,
                              :institucion_id => self.institucion.id,
                              :usuario_id => self.enlace.id,
                              :fecha_asignacion => solicitud.fecha_creacion,
                              :textoactividad => solicitud.textosolicitud,
                              :estado_id => actividad_estado_id,
                              :fecha_resolucion => solicitud.fecha_completada,
                              :dont_send_email => true)
    actividad.save!

    return actividad
  end

  def agregar_seguimiento(solicitud, actividad)

    logger.debug { "Agregando Seguiimiento" }

    actividad.seguimientos << Seguimiento.new(:institucion_id => self.institucion.id,
                                              :usuario_id  => self.enlace.id,
                                              :fecha_creacion => solicitud.fecha_entregada,
                                              :textoseguimiento => 'Seguimiento generado automáticamente por proceso de migración de datos.',
                                              :informacion_publica => true)

    logger.debug { "Marcando actividad como terminada." }
    actividad.marcar_como_terminada(solicitud.fecha_entregada)

  end

  def agregar_resolucion(solicitud, es_prorroga = false)
    logger.debug { "Agregando resolucion" }

    e = solicitud.estado
    tr = e.tiporesoluciones.first
    rtr = tr.razonestiposresoluciones.first

    #verificamos si es prorroga
    nueva_fecha = ( es_prorroga ? solicitud.fecha_prorroga : nil )

    #utilizamos la fecha de entrega como fecha de resolucion
    fecha_resolucion = ( es_prorroga ? solicitud.fecha_prorroga : solicitud.fecha_entregada)

    solicitud.resoluciones << Resolucion.new(:usuario_id => self.enlace.id,
                                             :institucion_id => self.institucion.id,
                                             :descripcion => 'Resolución generada automáticamente por proceso de migración de datos.',
                                             :tiporesolucion_id => tr.id,
                                             :razontiporesolucion_id => rtr.id,
                                             :informacion_publica => true,
                                             :documentoclasificacion_id => self.clasificacion_resolucion,
                                             :dont_send_email => true,
                                             :nueva_fecha => nueva_fecha,
                                             :fecha => fecha_resolucion,
                                             :fecha_notificacion => fecha_resolucion)
    solicitud.fecha_prorroga = nueva_fecha
    solicitud.save!
  end

  def extraer_valores(row, campos)
    logger.debug { "Extrayendo valores de row" }
    valores = {}

    via_id = obtener_valor(row[campos['via']], 1)

    fecha_creacion = date(row[campos['fecha']])
    fecha_programada = date(row[campos['fecha_limite']])
    fecha_entregada = date(row[campos['fecha_resolucion']]) #TODO
    fecha_prorroga = date(row[campos['fecha_prorroga']])
    fecha_completada = date(row[campos['fecha_resolucion']]) #TODO
    solicitante_nombre = row[campos['solicitante']]
    solicitante_identificacion = row[campos['cedula']]
    solicitante_direccion = row[campos['direccion']]
    solicitante_telefonos = row[campos['telefono']]
    solicitante_institucion = '' #TODO

    departamento_id = nil
    municipio_id = nil

    email = '' # TODO
    forma_entrega = ''
    observaciones = ''
    ubicacion_url = ''
    estado_id = 1
    textosolicitud = obtener_valor(row[campos['solicitud']], 'No Disponible')
    asignada = true
    ano = Date.today.year #TODO
    profesion_id = nil
    genero_id = nil
    rangoedad_id = nil
    clasificacion_id = nil
    dias_respuesta = row[campos['dias_respuesta']]
    dias_prorroga = row[campos['dias_prorroga']]
    motivonegativa_id = row[campos['razon_negativa']]
    motivoprorroga_id = row[campos['razon_prorroga']]
    resoluciones = row[campos['numero_resoluciones']] #TODO
    informacion_publica = true
    origen_id = Solicitud::ORIGEN_MIGRACION
    documentoclasificacion_id = self.clasificacion

    valores[:usuario_id] = self.enlace.id
    valores[:codigo] = nil
    valores[:institucion_id] = self.institucion.id
    valores[:tiposolicitud_id] = Solicitud::TIPO_INFORMACION
    valores[:via_id] = via_id
    valores[:fecha_creacion] = fecha_creacion
    valores[:fecha_programada] = fecha_programada
    valores[:fecha_entregada] = fecha_entregada
    valores[:fecha_prorroga] = fecha_prorroga
    valores[:fecha_completada] = fecha_completada
    valores[:solicitante_nombre] = solicitante_nombre
    valores[:solicitante_identificacion] = solicitante_identificacion
    valores[:solicitante_direccion] = solicitante_direccion
    valores[:solicitante_telefonos] = solicitante_telefonos
    valores[:solicitante_institucion] = solicitante_institucion
    valores[:departamento_id] = departamento_id
    valores[:municipio_id] = municipio_id
    valores[:email] = email
    valores[:forma_entrega] = forma_entrega
    valores[:observaciones] = observaciones
    valores[:ubicacion_url] = ubicacion_url
    valores[:estado_id] = estado_id
    valores[:created_at] = fecha_creacion
    valores[:updated_at] = fecha_creacion
    valores[:textosolicitud] = textosolicitud
    valores[:asignada] = asignada
    valores[:ano] = ano
    valores[:profesion_id] = profesion_id,
    valores[:genero_id] = genero_id
    valores[:rangoedad_id] = rangoedad_id
    valores[:clasificacion_id] = clasificacion_id
    valores[:dias_respuesta] = dias_respuesta
    valores[:dias_prorroga] = dias_prorroga
    valores[:motivonegativa_id] = motivonegativa_id
    valores[:motivoprorroga_id] = motivoprorroga_id
    valores[:informacion_publica] = informacion_publica
    valores[:origen_id] = origen_id
    valores[:documentoclasificacion_id] = documentoclasificacion_id
    valores[:dont_send_email] = true

    logger.debug { "Valores obtenidos. #{valores.inspect}" }

    return valores
  end

  def obtener_estado(estado_nombre, d_creacion, d_programada, d_entregada, d_completada, d_prorroga)
    estado = {}
    e = Estado.find_by_nombre(estado_nombre)

    tr = (e.final ? e.tiporesoluciones.first : nil )
    rtr = (e.final ? tr.razonestiposresoluciones.first : nil)

    # la fecha programada de entrega SIEMPRE SON 10 DIAS POR LEY
    # solo se modifica si hay prorroga
    d_programada = d_creacion + 10

    # si no se encuentra en un estado final todas las fechas son NIL
    unless e.final?
      d_entregada = nil
      d_completada = nil
      d_prorroga = nil
    end

    estado[:id] = e.id
    estado[:en_tramite] = (e.final ? false : true)
    estado[:actividad_estado_id] = (e.final ? Actividad::ESTADO_COMPLETADA : Actividad::ESTADO_ACTIVA)
    estado[:tiporesolucion_id] = tr.id
    estado[:razontiporesolucion_id] = rtr.id
    estado[:fecha_programada] = d_programada
    estado[:fecha_entregada] = d_entregada
    estado[:fecha_completada] = d_completada
    estado[:fecha_prorroga] = d_prorroga

    return estado
  end

  def date(c_date)
    logger.debug { "Fecha: #{c_date}" }

    return nil if c_date.nil?

    a_date = c_date.split('/')
    return nil unless a_date.size == 3

    if a_date[2].size == 2
      a_date[2] = '20'+a_date[2]
    end

    new_date = Date.civil(a_date[2].to_i, a_date[1].to_i, a_date[0].to_i)

    logger.debug { "Nueva Fecha: #{new_date}" }
    return new_date
  end

  def obtener_valor(campo, valor_predeterminado)
    valor = nil
    if campo.nil?
      valor = valor_predeterminado
    else
      valor = campo
    end
    return valor
  end

  def logger
    RAILS_DEFAULT_LOGGER
  end


end
