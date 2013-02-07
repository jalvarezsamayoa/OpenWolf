class Actividad < ActiveRecord::Base
  #versioned :if => :guardar_version?

  ESTADO_ACTIVA = 1
  ESTADO_COMPLETADA = 3

  before_validation(:on => :create) do
    completar_informacion
  end

  after_destroy :actualizar_solicitud

  validates_presence_of :usuario_id, :institucion_id, :textoactividad
  validates_associated :solicitud

  after_create :actualizar_solicitud
  after_create :notificar_asignacion
  after_destroy :actualizar_solicitud

  attr_accessor :dont_send_email

  belongs_to :solicitud
  belongs_to :usuario
  belongs_to :institucion
  belongs_to :estado

  has_many :seguimientos, :dependent => :destroy

  scope :nocompletadas, :conditions=>["fecha_resolucion IS NULL" ]
  scope :completadas, :conditions=>["fecha_resolucion IS NOT NULL" ]

  def marcar_como_terminada(fecha = Date.today)
    #marcamos actividad como terminada
    self.estado_id = ESTADO_COMPLETADA
    self.fecha_resolucion = fecha
    if self.save
      #actualizamos el estado de la solicitud
      self.solicitud.actividad_terminada(fecha)
    else
      return false
    end
  end

  private

  def notificar_asignacion
    Notificaciones.delay.deliver_nueva_asignacion(self) unless (self.dont_send_email == true)
  end

  def actualizar_solicitud
    self.solicitud.actualizar_asignaciones unless self.solicitud.nil?
  end

  def completar_informacion
    self.institucion_id = self.usuario.institucion_id unless self.usuario.nil?
    self.fecha_asignacion = Date.today if self.fecha_asignacion.nil?
    self.estado_id = ESTADO_ACTIVA if self.estado_id.nil?
  end

  def guardar_version?
    return self.solicitud.guardar_version?
  end
end
# == Schema Information
#
# Table name: actividades
#
#  id               :integer         not null, primary key
#  institucion_id   :integer         not null
#  usuario_id       :integer         not null
#  fecha_asignacion :date            not null
#  textoactividad   :text            not null
#  estado_id        :integer         default(1), not null
#  fecha_resolucion :date
#  created_at       :datetime
#  updated_at       :datetime
#  solicitud_id     :integer         not null
#

