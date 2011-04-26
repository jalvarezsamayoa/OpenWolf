class Resolucion < ActiveRecord::Base
  versioned
  
  TIPO_ENTREGA = 1
  
  validates_presence_of :numero, :descripcion
  validates_uniqueness_of :numero

  belongs_to :solicitud
  belongs_to :usuario
  belongs_to :institucion
  belongs_to :tiporesolucion
  belongs_to :razontiporesolucion

  before_validation :cleanup
  after_save :actualizar_solicitud
  after_create :notificar_creacion
  after_destroy :revertir_resolucion

  attr_accessor :dont_send_email

  scope :negativas, :conditions => ["resoluciones.tiporesolucion_id = 3"]
  scope :prorrogas, :conditions => ["resoluciones.tiporesolucion_id = 4"]
  scope :tipo_positiva, where("tiposresoluciones.positiva = ?",true).includes(:tiporesolucion)
  scope :tipo_negativa, where("tiposresoluciones.positiva = ?",false).includes(:tiporesolucion)

  
  def nuevo_numero
    i = Resolucion.count(:conditions => ["institucion_id = ? and date_part(\'year\',created_at) = ?", self.institucion_id, Date.today.year ] ).to_i + 1
    
    self.numero = self.institucion.codigo + '-'+ Documentoclasificacion::RESOLUCION + '-' +  Date.today.year.to_s + '-' + i.to_s.rjust(6,'0')
  end

  def cleanup
    self.documentoclasificacion_id =  Documentoclasificacion.find_by_codigo(Documentoclasificacion::RESOLUCION).id
    self.numero = self.nuevo_numero if (self.numero.nil? or self.numero.empty?)
    
    unless self.nueva_fecha.nil?
      if self.nueva_fecha < self.solicitud.fecha_programada
        logger.debug { "Nueva fecha no es valida." }
      end
    end

    #verificamos existencia de fecha de resolucion
    # superudip tiene derecho a cambiarla o asignarla
    self.fecha = Date.today if self.fecha.nil?
    self.fecha_notificacion = Date.today if self.fecha_notificacion.nil?

    
    return true
  end

  # TODO: mover toda esta logica a modelo Solicitud
  def actualizar_solicitud
    logger.debug { "Resolucion#actualizar_solicitud" }
    
    unless self.nueva_fecha.nil?
      logger.debug { "Actualizando fecha solicitud." }
      logger.debug { "#{self.nueva_fecha}" }
      if self.nueva_fecha > self.solicitud.fecha_programada
        self.solicitud.fecha_prorroga = self.nueva_fecha
        self.solicitud.fecha_programada = self.nueva_fecha
      end      
    end

    self.solicitud.estado_id = self.tiporesolucion.estado_id
    self.solicitud.fecha_resolucion = self.created_at.to_date

    # si estado es final pero no debe entregar
    # actualizamos fecha de entrega
    # esto funciona en casos como una negativa
    if self.tiporesolucion.estado.final == true and self.tiporesolucion.estado.puede_entregar == false
      self.solicitud.fecha_entregada = Date.today
    end
    
    self.solicitud.save
  end

  def revertir_resolucion
    self.solicitud.fecha_prorroga = nil
    self.solicitud.fecha_resolucion = nil
    self.solicitud.fecha_programada = self.solicitud.calcular_fecha_entrega()
    self.solicitud.save(false)

    #obtener ultima resolucion
    r = self.solicitud.resoluciones.last
    if r
      r.actualizar_solicitud
    end
  end

  def notificar_creacion
    return true if self.solicitud.email.empty?
    Notificaciones.delay.deliver_nueva_resolucion(self) unless (self.dont_send_email == true)
    return true
  end
end
