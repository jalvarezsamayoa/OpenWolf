# -*- coding: utf-8 -*-
class Solicitud < ActiveRecord::Base
  include PgSearch

  ORIGEN_DEFAULT = 1
  ORIGEN_PORTAL = 2
  ORIGEN_MIGRACION = 3

  VIA_DEFAULT = 1
  TIPO_INFORMACION = 1
  TIPO_DENUNCIA = 2
  ESTADO_NORMAL = 1
  ESTADO_ENTREGADA = 3

  ESTADO_NOENTREGADA = false
  ESTADO_NOASIGNADA = false
  ESTADO_COMPLETADA = true
  ESTADO_NOCOMPLETADA = false
  TIEMPOS = [["Todos", "ALL"],
             ["10 dias", "10"],
             ["7 a 9 dias", "7a9"],
             ["4 a 6 dias", "4a6"],
             ["0 a 3 dias", "0a3"],
             ["Atrasadas", "LATE"]]

  IDIOMA_DEFAULT = 12 #ladino

  attr_accessor :dont_send_email
  attr_accessor :dont_set_estado

  attr_accessible :solicitante_nombre, :email, :textosolicitud, :reserva_temporal, \
  :genero_id, :idioma_id, :captcha, :origen_id, :institucion_id, \
  :solicitante_telefonos, :captcha_key

  #####################
  # Modulos y Plugins
  #####################

  #versioned :if => :guardar_version?

  apply_simple_captcha


  #--------------------------------
  # Configuracion indexamiento pg_search
  #--------------------------------

  pg_search_scope(:text_search,
                  :against => [:codigo, :solicitante_nombre, :textosolicitud],
                  :using => [:tsearch])

  #######################
  # Configuracion Solr
  ######################

  # searchable do
  #   text :codigo
  #   integer :numero
  #   text :solicitante_nombre
  #   text :textosolicitud, :default_boost => 2
  #   text :observaciones
  #   date :fecha_creacion
  #   date :fecha_programada
  #   time :created_at
  #   integer :institucion_id, :references => Institucion
  #   integer :municipio_id, :references => Municipio
  #   integer :departamento_id, :references => Departamento
  #   integer :via_id, :references => Via
  #   integer :estado_id, :references => Estado
  #   integer :clasificacion_id, :references => Clasificacion
  #   integer :documentoclasificacion_id, :references => Documentoclasificacion
  #   integer :idioma_id, :references => Idioma
  #   boolean :anulada
  #   text :lowcase_solicitante_nombre do
  #     clean_string(solicitante_nombre.downcase)
  #   end
  #   text :lowcase_textosolicitud do
  #     clean_string(textosolicitud.downcase)
  #   end
  # end

  ##################
  # Callbacks
  # http://apidock.com/rails/v2.3.8/ActiveRecord/Callback
  ##################

  before_validation :cleanup
  before_validation(:on => :create) do
    completar_informacion
  end
  after_create :notificar_creacion

  #################
  # Relaciones
  #################


  belongs_to :institucion
  belongs_to :usuario
  belongs_to :municipio
  belongs_to :departamento
  belongs_to :via
  belongs_to :estado
  belongs_to :profesion
  belongs_to :genero
  belongs_to :rangoedad
  belongs_to :clasificacion
  belongs_to :motivonegativa
  belongs_to :motivoprorroga
  belongs_to :documentoclasificacion
  belongs_to :idioma

  has_many :actividades, :dependent => :destroy
  has_many :seguimientos, :through => :actividades

  has_many :adjuntos, :as => :proceso, :dependent => :destroy
  has_many :notas, :as => :proceso, :dependent => :destroy
  has_many :resoluciones, :dependent => :destroy
  has_many :recursosrevision, :dependent => :destroy

  has_many :enlaces, :through => :actividades, :uniq => true, :source => :usuario

  #######################
  # Validaciones
  ######################

  validates_presence_of :fecha_creacion, :solicitante_nombre, :textosolicitud, :institucion_id
  validates_presence_of :solicitante_telefonos, :if => Proc.new{ |s| (s.origen_id == ORIGEN_PORTAL ? true : false) }

  validates_presence_of :email, :if => Proc.new{ |s| (s.origen_id == ORIGEN_PORTAL ? true : false) }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :unless => Proc.new{ |s| s.email.nil? or s.email.empty? }, :message => "Correo electrónico no es válido."


  validates_associated :estado

  ########################
  # Filtros
  ########################
  default_scope :include => [:usuario, :institucion, :via, :estado]

  scope :activas, where("solicitudes.anulada = ?", false)
  scope :anuladas, where("solicitudes.anulada = ?", true)

  #  scope :asignadas, :conditions=>["solicitudes.asignada = ?", true ]
  scope :asignadas, where("solicitudes.asignada = ?", true )
  scope :noasignadas, where("solicitudes.asignada = ?", false)

  scope :completadas, where("solicitudes.fecha_completada is not null")
  scope :nocompletadas, where("solicitudes.fecha_completada is null")

  scope :sinresolucion, where("solicitudes.fecha_resolucion is null")
  scope :conresolucion, where("solicitudes.fecha_resolucion is not null")

  scope :sinresolucionfinal, where("(solicitudes.fecha_resolucion is null) or (solicitudes.fecha_resolucion is not null and estados.final = ?)",false )
  scope :conresolucionfinal, where("(solicitudes.fecha_resolucion is not null) and (estados.final = ?)", true )


  scope :entregadas, where("solicitudes.fecha_entregada is not null")
  scope :noentregadas, where("solicitudes.fecha_entregada is null")

  scope :recientes, :order => "fecha_creacion desc"
  scope :correlativo, :order => "ano desc, numero desc"

  scope :creadas_en_ano, lambda {|ano| where( "date_part(\'year\',fecha_creacion) = ?",ano) }

  scope :tiempoejecucion, lambda { |tiempo_desde, tiempo_hasta| {
      :conditions => ["(((fecha_programada - ?)*100)/10) between ? and ?",Date.today, tiempo_desde, tiempo_hasta]
    }}

  scope :tiempo_transcurrido, lambda { |tiempo_desde, tiempo_hasta| {
      :conditions => ["(current_date - fecha_creacion) between ? and ?",tiempo_desde, tiempo_hasta]
    }}

  scope :tiempo_restante, lambda { |tiempo_desde, tiempo_hasta| {
      :conditions => ["(fecha_programada - current_date) between ? and ?",tiempo_desde, tiempo_hasta]
    }}


  ################################
  # Metodos de Instancia Publicos
  ###############################

  def puede_mostrar_informacion?
    return false unless self.informacion_publica?

    # si tiene reserva temporal no se puede mostrar
    #hasta que tenga resolucion final
    if self.reserva_temporal?
      return self.con_resolucion_final?
    end

    return true
  end

  # marca solicitud como anulada
  def anular
    self.anulada = true
    self.save
  end

  def es_pertinente?(u)
    return false if u.nil? #TODO verificar porque no recibe usuario
    return false if u.institucion.nil? or self.institucion.nil?

    l_ok = false


    #verficamos si es miembro de la unidad de informacion
    # de la institucion a la cual pertenece la solicitud
    if u.institucion_id == self.institucion_id
      if u.has_role?(:superudip) or u.has_role?(:userudip)
        l_ok = true
      end
    end

    #verificamos si el usuario es un enlace asignado a esta solicitud
    if l_ok == false
      if self.actividades.count(:conditions => ["usuario_id = ?", u.id]) > 0
        l_ok = true
      end
    end

    return l_ok
  end

  # retorna todas las razones que se dieron
  # en las resoluciones que no sean una entrega total
  def razon_nopositiva
    c_razon = ''
    res = self.resoluciones.tipo_negativa
    unless res.nil?
      for r in res
        c_razon += r.tiporesolucion.nombre + ":" + r.descripcion + "\n"
      end
    end
    return c_razon
  end

  def razon_negativa
    negativa = self.resoluciones.negativas.last
    if negativa.nil?
      return ''
    else
      negativa.descripcion
    end
  end

  def razon_ampliacion
    ampliacion = self.resoluciones.prorrogas.last
    if ampliacion.nil?
      return ''
    else
      ampliacion.descripcion
    end
  end

  def razon_resolucion
    r = self.resoluciones.tipo_positiva.last
    if r.nil?
      c_razon = ''
    else
      c_razon = r.descripcion
    end
    return c_razon
  end


  def tipo_resolucion(r = nil)
    r = self.resoluciones.last if r.nil?
    if r.nil?
      c_razon = 'Pendiente'
    else
      c_razon = r.tiporesolucion.aliaspdh
    end
    return c_razon
  end

  def hay_prorroga
    cnt = self.resoluciones.prorrogas.count
    return (cnt > 0 ? 'Si' : 'No')
  end

  def razon_prorroga
    p = self.resoluciones.prorrogas.last
    razon = p.nil? ? '' : p.razontiporesolucion.nombre
    return razon
  end

  def fecha_notificacion_prorroga
    p = self.resoluciones.prorrogas.last
    fecha = p.nil? ? nil : p.created_at.to_date
    return fecha
  end

  def hay_revision
    cnt = self.recursosrevision.count
    return (cnt > 0 ? 'Si' : 'No')
  end

  def fecha_revision
    r = self.recursosrevision.last
    fecha = r.nil? ? nil : r.fecha_presentacion
    return fecha
  end

  def razon_revision
    r = self.recursosrevision.last
    if r.nil?
      c_razon = ''
    else
      c_razon = r.sentidoresolucion.nombre
    end
    return c_razon
  end


  def fecha_notificacion_revision
    r = self.recursosrevision.last
    fecha = r.nil? ? nil : r.fecha_notificacion
    return fecha
  end

  def fecha_ultima_resolucion
    r = self.resoluciones.last
    fecha = r.nil? ? nil : r.created_at.to_date
    return fecha
  end

  def tiempo_ampliacion
    p = self.resoluciones.prorrogas.last

    return 0 if p.nil?
    return 0 unless self.tiempo_respuesta > 0

    tiempo = (self.tiempo_respuesta - 10)

    return 0 if tiempo < 0
    return tiempo

    #resolucion_final = self.resoluciones.finales.last


    # si no hay resolucion final
    # tiempo de amplicacion es a partir de nueva fecha
    # if resolucion_final.nil?
    #       return (p.nueva_fecha - self.fecha_programada).to_i
    # end

    #si hay resolucion final
    # tiempo = (resolucion_final.fecha - self.fecha_programada).to_i
    # tiempo = 0 if tiempo < 0

    # return tiempo
  end

  def dias_transcurridos
    i_tiempo = 0
    if self.fecha_completada.nil?
      i_tiempo = (Date.today - self.fecha_creacion)
    else
      i_tiempo = self.tiempo_respuesta
    end

    return i_tiempo
  end

  #regresa un array con informacion
  #usado en reportes o para exportar data
  def to_item
    resolucion = self.resoluciones.last
    revision = self.recursosrevision.last
    prorroga = self.resoluciones.prorrogas.last

    return [self.codigo,
            self.textosolicitud,
            self.fecha_creacion,
            self.via.nombre,
            self.tipo_resolucion(resolucion)]
  end

  def texto_solicitud(user = nil)
    c_texto = self.textosolicitud
    unless self.puede_mostrar_informacion?
      if user.nil? or !user.has_role?(:superudip)
        c_texto ='Información bajo reserva.'
      end
    end
    return c_texto
  end

  def extracto(user = nil)
    c_texto = self.textosolicitud[0..100] + '...'
    unless self.puede_mostrar_informacion?
      if user.nil? or !user.has_role?(:superudip)
        c_texto ='Información bajo reserva'
      end
    end
    return c_texto
  end

  def estado_actual
    return 'ANULADA' if self.anulada?
    return estado.nombre
  end

  def asignada?
    return (self.asignada == true)
  end

  def atrasada?
    l_ok = false
    unless terminada? or entregada?
      if dias_restantes <= 0
        l_ok = true
      end
    end
    return l_ok
  end

  def terminada?
    return (not self.fecha_completada.nil?)
  end

  def entregada?
    return (not self.fecha_entregada.nil?)
  end

  def con_resolucion_final?
    return ( (!self.fecha_resolucion.nil?) and (self.estado.final == true) )
  end

  def avance
    n_avance = 0.00
    if terminada?
      n_avance = 100.00
    else
      i_actividades = self.actividades.count
      unless i_actividades == 0
        i_completadas = self.actividades.completadas.count
        n_avance = ((i_completadas * 100)/i_actividades).to_f
      else
        n_avance = 0.00
      end
    end
    return n_avance
  end

  def dias_restantes
    dias = (fecha_programada - Date.today)
    return 0 if self.terminada? or dias < 0
    return dias
  end

  def actualizar_asignaciones
    cnt_asignaciones = self.actividades.count

    #actualizamos el estado de entrega
    if cnt_asignaciones > 0
      #actualizamos el estado de asignacion
      self.asignada = true
      self.marcar_como_terminada
    else
      self.asignada = false
      self.marcar_como_no_terminada
    end

    self.save!
  end

  #actualiza el estado de la solicitud segun el estado de sus
  #actividades
  def actividad_terminada(fecha = Date.today)
    self.marcar_como_terminada(fecha)
    self.save
  end

  # marca solicitud como terminada
  def marcar_como_terminada(fecha = Date.today)
    self.fecha_completada = fecha if ( self.actividades.count == self.actividades.completadas.count)
  end


  #marca la solicitud como no terminada
  def marcar_como_no_terminada
    self.fecha_completada = nil
    #actualizamos los tiempos de entrega
    self.tiempo_respuesta = 0
    self.tiempo_respuesta_calendario = 0
  end

  #actualiza el estado a Entregada a Solicitante
  def solicitud_entregada(date = Date.today)
    self.fecha_entregada = date
    self.estado_id = ESTADO_ENTREGADA
    self.save!
  end

  #retorna string con nombres de enlaces asignados
  def nombres_enlaces
    return 'Solicitud no tiene enlaces.' if self.enlaces.count == 0

    c_nombres = ''
    self.enlaces.each do |e|
      c_nombres += e.nombre + ', '
    end
    c_nombres = c_nombres.strip.chop

    return c_nombres
  end

  #retorna un arreglo con los correos electronicos
  # de las personas relacionadas a la notificacion
  def correos_interesados(l_incluir_ciudadano = true)
    correos = []

    #usuarios unidad informacion
    usuarios_udip = self.institucion.usuarios.activos.udip
    usuarios_udip.each { |u|
      correos << u.email unless u.email.empty?
    }

    #ciudadano si hay correo
    if l_incluir_ciudadano
      correos << self.email unless self.email.empty?
    end

    #enlaces
    self.enlaces.each { |e|
      correos << e.email unless e.email.empty?
    }

    return correos
  end

  #indica si se graba una version
  def guardar_version?
    return (self.origen_id == ORIGEN_MIGRACION ? false : true)
  end

  def self.xml_options
    options = {:institucion => {:only => [:codigo, :nombre, :abreviatura] },
      :usuario => {:only => [:nombre, :cargo, :username]},
      :municipio => {:only => [:nombre]},
      :departamento => {:only => [:nombre]},
      :via => {:only => [:nombre]},
      :estado => {:only => [:nombre]},
      :profesion => {:only => [:nombre]},
      :genero => {:only => [:nombre]},
      :rangoedad => {:only => [:nombre]},
      :clasificacion => {:only => [:nombre]},
      :documentoclasificacion => {:only => [:nombre]},
      :idioma => {:only => [:nombre]},
      :actividades => {:only => [:fecha_resolucion,
                                 :fecha_asignacion,
                                 :estado_id,
                                 :usuario_id,
                                 :textoactividad],
        :include => {:estado => {:only => [:nombre] },
          :usuario => {:only => [:nombre,
                                 :cargo,
                                 :username]  },
          :seguimientos => {:only => [:usuario_id,
                                      :fecha_creacion,
                                      :textoseguimiento,
                                      :informacion_publica],
            :include => {:usuario => {:only => [:nombre, :cargo, :username]}}}
        }
      },
      :resoluciones => {:only => [:informacion_publica,
                                  :razontiporesolucion_id,
                                  :tiporesolucion_id,
                                  :usuario_id,
                                  :descripcion,
                                  :documentoclasificacion_id,
                                  :numero,
                                  :fecha,
                                  :nuevafecha,
                                  :fecha_notificacion],
        :include => {:usuario => {:only => [:nombre, :cargo, :username]},
          :tiporesolucion => {:only => [:nombre]},
          :razontiporesolucion => {:only => [:nombre] }
        }
      },
      :recursosrevision => {:only => [:fecha_presentacion,
                                      :fecha_notificacion,
                                      :fecha_resolucion,
                                      :descripcion,
                                      :sentidoresolucion_id,
                                      :usuario_id,
                                      :numero,
                                      :documentoclasificacion_id],
        :include => {:usuario => {:only => [:nombre, :cargo, :username]},
          :sentidoresolucion => {:only => [:nombre]}
        }
      }
    }
    return options
  end

  # retorna configuracion para exportacion a xml
  def xml_options
    Solicitud.xml_options
  end


  def self.get_csv_records(csv, solicitudes)
    if solicitudes.respond_to?(:each)
      solicitudes.each do |s|
        csv << self.get_csv_record(s)
      end
    else
      solicitudes.each_hit_with_result do |hit, s|
        csv << self.get_csv_record(s)
      end
    end
  end

  def self.get_csv_record(s)
    [s.institucion.nombre,
     s.codigo,
     s.textosolicitud.tr('"','\'').gsub(/\n/,"").gsub(/\r/,"").gsub(/\t/,""),
     I18n.l(s.fecha_creacion).to_s,
     (s.via.nil? ? '' : s.via.nombre),
     s.tipo_resolucion,
     (I18n.l(s.fecha_resolucion).to_s unless s.fecha_resolucion.nil?),
     s.razon_nopositiva.gsub(/\n/,"").gsub(/\r/,""),
     s.dias_transcurridos.to_s,
     s.hay_prorroga,
     (I18n.l(s.fecha_notificacion_prorroga).to_s unless s.fecha_notificacion_prorroga.nil?),
     s.razon_prorroga.gsub(/\n/,"").gsub(/\r/,""),
     s.tiempo_ampliacion.to_s,
     s.hay_revision,
     (I18n.l(s.fecha_revision).to_s unless s.fecha_revision.nil?),
     (I18n.l(s.fecha_notificacion_revision).to_s unless s.fecha_notificacion_revision.nil?),
     s.razon_revision.gsub(/\n/,"").gsub(/\r/,"")]
  end


  def self.export_to_csv(opts = {})

    if opts[:solicitudes]
      solicitudes = opts[:solicitudes]
    else
      if opts[:institucion_id]
        i_institucion_id = opts[:institucion_id] #  usuario_actual.institucion_id

        d_desde = Date.new(opts[:desde][2].to_i, opts[:desde][1].to_i, opts[:desde][0].to_i)
        d_hasta = Date.new(opts[:hasta][2].to_i, opts[:hasta][1].to_i, opts[:hasta][0].to_i)

        solicitudes = Solicitud.find(:all, :conditions => ["solicitudes.institucion_id = ? and solicitudes.anulada = ? and solicitudes.fecha_creacion between ? and ?", i_institucion_id, false, d_desde, d_hasta], :order => :numero)
      end
    end

    csv_string = FasterCSV.generate do |csv|
      csv <<  [Solicitud.human_attribute_name(:rpt_institucion),
               Solicitud.human_attribute_name(:rpt_correlativo),
               Solicitud.human_attribute_name(:rpt_solicitud),
               Solicitud.human_attribute_name(:rpt_fechasolicitud),
               Solicitud.human_attribute_name(:rpt_tipodesolicitud),
               Solicitud.human_attribute_name(:rpt_tipoderesolucion),
               Solicitud.human_attribute_name(:rpt_fecharesolucion),
               Solicitud.human_attribute_name(:rpt_razonnopositiva),
               Solicitud.human_attribute_name(:rpt_tiempoderespuesta),
               Solicitud.human_attribute_name(:rpt_sehasolicitadoampliacion),
               Solicitud.human_attribute_name(:rpt_fechanotificacionampliacion),
               Solicitud.human_attribute_name(:rpt_razonampliacion),
               Solicitud.human_attribute_name(:rpt_tiemposolicitadoampliacion),
               Solicitud.human_attribute_name(:rpt_recursorevision),
               Solicitud.human_attribute_name(:rpt_fechapresentacionrecursorevision),
               Solicitud.human_attribute_name(:rpt_fechanotificacionrecursorevision),
               Solicitud.human_attribute_name(:rpt_sentidoresolucion)
              ]

      self.get_csv_records(csv, solicitudes)
    end
    return csv_string
  end


  ################################
  # Metodos de Instancia Privados
  # http://apidock.com/ruby/Module/private
  ################################

  def notificar_creacion
    unless (self.email.nil? or self.email.blank?)
      Notificaciones.delay.nueva_solicitud(self, Time.now, true) unless (self.dont_send_email == true)
    end

    Notificaciones.delay.nueva_solicitud(self, Time.now, false) unless (self.dont_send_email == true)
  end

  def calcular_fecha_entrega
    Solicitud.calcular_fecha_entrega(self.fecha_creacion, nil,  self.institucion_id)
  end

  def self.calcular_fecha_entrega(d_fecha_creacion = Date.today, d_fecha_entrega = nil, i_institucion_id = 1)
    logger.debug { "Solicitud: calculando fecha de entrega" }
    d_fecha_creacion = d_fecha_creacion.to_date if d_fecha_creacion.class == String
    d_fecha_entrega = d_fecha_creacion + 14.days unless d_fecha_entrega

    logger.debug { "Solcitud fecha: #{d_fecha_entrega}" }

    #obtenemos feriados entre las fechas
    feriados_locales = []
    feriados_nacionales = Feriado.nacional.entre_fechas(d_fecha_creacion, d_fecha_entrega)
    feriados_locales = Feriado.local.por_institucion(i_institucion_id).entre_fechas(d_fecha_creacion, d_fecha_entrega) unless i_institucion_id == 1

    logger.debug { "Solicitud Aumentando dias segun feriados nacinales" }
    #aumentamos los dias de la solicitud segun los feriados
    unless feriados_nacionales.blank?
      for feriado in feriados_nacionales
        if feriado.es_dia_laboral?
          d_fecha_entrega += 1.day
        end
      end
    end

    logger.debug { "Solcitud fecha: #{d_fecha_entrega}" }

    logger.debug { "Solicitud Aumentando dias segun feriados locales" }
    unless feriados_locales.blank?
      for feriado in feriados_locales
        if feriado.es_dia_laboral?
          d_fecha_entrega += 1.day
        end
      end
    end

    logger.debug { "Solcitud fecha: #{d_fecha_entrega}" }

    logger.debug { "Solicitud Aumentando dias segun dias laborales" }
    # verificamos que la nueve fecha sea dia laboral
    d_fecha_entrega += 1.day if (d_fecha_entrega.wday == 6)
    d_fecha_entrega += 1.day if (d_fecha_entrega.wday == 0)

    logger.debug { "Solcitud fecha: #{d_fecha_entrega}" }

    d_fecha_entrega = Feriado.obtener_fecha_valida(d_fecha_entrega, i_institucion_id)


    logger.debug { "Solcitud fecha: #{d_fecha_entrega}" }

    return d_fecha_entrega
  end

  private

  def completar_informacion
    #validamos el origen de la solicitud
    # y determinamos institucion y usuario a utilizar

    if self.origen_id == ORIGEN_DEFAULT
      # usa current_user para obtenerlo
      self.institucion_id = self.usuario.institucion_id
    elsif self.origen_id == ORIGEN_PORTAL
      #si el orgen es el portal no hay usuario
      # asi que usamos el usuario de tipo ciudadano

      #verificamos si hay institucion
      unless self.institucion_id.nil?
        ciudadano = self.institucion.usuarios.activos.ciudadanos.first
        self.usuario_id = ciudadano.id
      end

      #si es orgien portal la via es internet
      self.via_id = 4 #internet
    else
      # si es migracion usamos al primer usario de UDIP
      superudip = self.institucion.usuarios.activos.supervisores.first
      self.usuario_id = superudip.id
    end

    # validamos si hay institucion asignada
    unless self.institucion.nil?

      if self.origen_id != ORIGEN_MIGRACION
        logger.debug { "#{self.fecha_creacion}" }
        self.fecha_creacion = Date.today if self.fecha_creacion.nil?
        logger.debug { "#{self.fecha_creacion}" }

        self.fecha_programada = calcular_fecha_entrega()

        self.departamento_id = municipio.departamento_id unless municipio.nil?

        if self.dont_set_estado.nil?
          self.estado_id = ESTADO_NORMAL if self.estado_id.nil?
        end

        self.asignada = false
        self.solicitante_identificacion = 'No Disponible' if self.solicitante_identificacion.nil?
      end

      self.ano = self.fecha_creacion.year
      self.tiposolicitud_id = TIPO_INFORMACION
      self.documentoclasificacion_id = Documentoclasificacion.find_by_codigo(Documentoclasificacion::SOLICITUDINFOPUBLICA).id
      self.numero = proximo_numero_solicitud
      self.codigo = generar_codigo()
      self.forma_entrega = 'No Disponible' if self.forma_entrega.nil?
      self.idioma_id = IDIOMA_DEFAULT if self.idioma_id.nil?

    end # institucion.nil?

  end

  def proximo_numero_solicitud
    Solicitud.maximum(:numero, :conditions => ["solicitudes.institucion_id = ? and solicitudes.ano = ?",self.institucion_id, self.ano]).to_i + 1
  end

  def generar_codigo
    self.institucion.codigo + '-'+Documentoclasificacion::SOLICITUDINFOPUBLICA+'-' +  self.ano.to_s + '-' + self.numero.to_s.rjust(6,'0')
  end

  #limpia la informacion de la solicitud
  def cleanup
    self.solicitante_nombre = self.solicitante_nombre.slice(0..254)
  end

  #removes spetial characters for indexing
  def clean_string(c_name)

    c_name = c_name.tr('á','a')
    c_name = c_name.tr('é','e')
    c_name = c_name.tr('í','i')
    c_name = c_name.tr('ó','o')
    c_name = c_name.tr('ú','u')

    c_name = c_name.tr('Á','A')
    c_name = c_name.tr('É','E')
    c_name = c_name.tr('Í','I')
    c_name = c_name.tr('Ó','O')
    c_name = c_name.tr('Ú','U')

    return c_name
  end





end
# == Schema Information
#
# Table name: solicitudes
#
#  id                          :integer         not null, primary key
#  usuario_id                  :integer         not null
#  codigo                      :string(255)     default("XXXXX-999999-9999"), not null
#  institucion_id              :integer         not null
#  tiposolicitud_id            :integer         default(1)
#  via_id                      :integer         default(1), not null
#  fecha_creacion              :date
#  fecha_programada            :date
#  fecha_entregada             :date
#  fecha_resolucion            :date
#  fecha_prorroga              :date
#  fecha_completada            :date
#  solicitante_nombre          :string(255)     not null
#  solicitante_identificacion  :string(255)
#  solicitante_direccion       :string(255)
#  solicitante_telefonos       :string(255)
#  solicitante_institucion     :string(255)
#  departamento_id             :integer
#  municipio_id                :integer
#  email                       :string(255)
#  forma_entrega               :string(255)
#  observaciones               :text
#  ubicacion_url               :string(255)
#  estado_id                   :integer         default(1)
#  created_at                  :datetime
#  updated_at                  :datetime
#  textosolicitud              :text
#  asignada                    :boolean
#  ano                         :integer         not null
#  numero                      :integer         not null
#  profesion_id                :integer
#  genero_id                   :integer
#  rangoedad_id                :integer
#  clasificacion_id            :integer
#  dias_respuesta              :integer
#  dias_prorroga               :integer
#  motivonegativa_id           :integer
#  motivoprorroga_id           :integer
#  informacion_publica         :boolean         default(TRUE), not null
#  origen_id                   :integer         default(1)
#  documentoclasificacion_id   :integer         default(1)
#  idioma_id                   :integer         default(12), not null
#  anulada                     :boolean         default(FALSE)
#  tiempo_respuesta            :integer         default(0)
#  tiempo_respuesta_calendario :integer         default(0)
#  reserva_temporal            :boolean         default(FALSE)
#
