# -*- coding: utf-8 -*-
require 'rubygems'
require 'fastercsv'

class Herramienta
  attr_reader :institucion

  def initialize
    @institucion = nil
    @enlace = nil
  end

  # :path Archivo csv con la informacion
  # :institucion_id Id de institucio hacia donde se importan los datos
  # :usuario_id Id de usuario que importa datos
  def importar_solicitudes(options)
    file = options[:file]
    @institucion = Institucion.find(options[:institucion_id])
    campos = options[:campos]

    logger.debug { "Campos #{campos.inspect}" }
    usuario_id = options[:usuario_id]

    logger.debug { "Borrando solicitudes de institucion." }
    @institucion.solicitudes.clear
    logger.debug { "Solicitudes borradas." }

    # agregar enlaces
    # usar por default el usuario jefe de la unidad de informacion
    @enlace = @institucion.usuarios.supervisores.first

    linea = 0
    logger.debug { "Importando..." }
    csv_doc = FasterCSV.new(file, {:headers => true, :encoding => 'utf8', :skip_blanks => true})
    csv_doc.each do |row|
      linea += 1
      logger.debug { "Linea #{linea}" }

      # no tomamos en cuenta solicitudes sin texto
      unless row[campos['solicitud']].nil? or row[campos['solicitud']].empty?

        via_id = obtener_valor(row[campos['via']], 1)

        logger.debug { "campos: #{campos.inspect}" }
        logger.debug { "row: #{row[campos['fecha']]}" }

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
        departamento_id = obtener_valor(row[campos['departamento']], 1)

        municipio_nombre = obtener_valor(row[campos['municipio']], 'Guatemala')

        municipio_id = Municipio.find(:first, :conditions => ["municipios.nombre = ? and municipios.departamento_id = ?",municipio_nombre,departamento_id]) #TODO

        estado = obtener_estado(row[campos['estatus']], fecha_creacion, fecha_programada, fecha_entregada, fecha_completada, fecha_prorroga)

        #sobrescribimos #el valor segun el estado
        fecha_programada = estado[:fecha_programada]
        fecha_entregada = estado[:fecha_entregada]
        fecha_completada = estado[:fecha_completada]
        fecha_prorroga = estado[:fecha_prorroga]

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
        documentoclasificacion_id = 1


        s = Solicitud.new(:usuario_id => nil,
                          :codigo => nil,
                          :institucion_id => @institucion.id,
                          :tiposolicitud_id => Solicitud::TIPO_INFORMACION,
                          :via_id => via_id,
                          :fecha_creacion => fecha_creacion,
                          :fecha_programada => fecha_programada,
                          :fecha_entregada => fecha_entregada,
                          :fecha_prorroga => fecha_prorroga,
                          :fecha_completada => fecha_completada,
                          :solicitante_nombre => solicitante_nombre,
                          :solicitante_identificacion => solicitante_identificacion,
                          :solicitante_direccion => solicitante_direccion,
                          :solicitante_telefonos  => solicitante_telefonos,
                          :solicitante_institucion => solicitante_institucion,
                          :departamento_id => departamento_id,
                          :municipio_id => municipio_id,
                          :email => email,
                          :forma_entrega => forma_entrega,
                          :observaciones => observaciones,
                          :ubicacion_url => ubicacion_url,
                          :estado_id => estado_id,
                          :created_at => fecha_creacion,
                          :updated_at => fecha_creacion,
                          :textosolicitud => textosolicitud,
                          :asignada => asignada,
                          :ano => ano,
                          :profesion_id => profesion_id,
                          :genero_id => genero_id,
                          :rangoedad_id => rangoedad_id,
                          :clasificacion_id => clasificacion_id,
                          :dias_respuesta => dias_respuesta,
                          :dias_prorroga => dias_prorroga,
                          :motivonegativa_id => motivonegativa_id,
                          :motivoprorroga_id => motivoprorroga_id,
                          :informacion_publica => informacion_publica,
                          :origen_id => origen_id,
                          :documentoclasificacion_id => documentoclasificacion_id,
                          :dont_send_email => true  )

        s.save!

        #assigar enalces / actividades
        s.actividades << Actividad.new(:institucion_id => @institucion.id,
                                       :usuario_id => @enlace.id,
                                       :fecha_asignacion => s.fecha_creacion,
                                       :textoactividad => s.textosolicitud,
                                       :estado_id => estado[:actividad_estado_id],
                                       :fecha_resolucion => s.fecha_completada,
                                       :dont_send_email => true)

        # si la solicitud esta en tramite NO TIENE seguimientos o resoluciones
        if (estado[:en_tramite] == false)

          #seguimientos
          actividad = s.actividades.first
          actividad.seguimientos << Seguimiento.new(:institucion_id => @institucion.id,
                                                    :usuario_id  => @enlace.id,
                                                    :fecha_creacion => s.fecha_entregada,
                                                    :textoseguimiento => 'Seguimiento generado automáticamente por proceso de migración de datos.',
                                                    :informacion_publica => true)


          actividad.marcar_como_terminada(s.fecha_entregada)

          #resoluciones
          unless s.fecha_completada.nil?
            s.resoluciones << Resolucion.new(:usuario_id => @enlace.id,
                                             :institucion_id => @institucion.id,
                                             :descripcion => 'Resolución generada automáticamente por proceso de migración de datos.',
                                             :tiporesolucion_id => estado[:tiporesolucion_id],
                                             :razontiporesolucion_id => estado[:razontiporesolucion_id],
                                             :informacion_publica => true,
                                             :documentoclasificacion_id => 1,
                                             :dont_send_email => true)
          end

        end #en_tramite = true



      end
    end
    csv_doc.close

  end

  def importar_enlaces(options)

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

  def logger
    RAILS_DEFAULT_LOGGER
  end
end
