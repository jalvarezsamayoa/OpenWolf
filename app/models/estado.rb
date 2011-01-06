class Estado < ActiveRecord::Base
  versioned
  
  MODULOS = [['LAIP',1],['MENSAJES',2]]
  MODULO_LAIP = 1
  MODULO_MENSAJES = 2

  validates :nombre, :presence => true, :uniqueness => true
   
  has_many :solicitudes
  has_many :tiporesoluciones

  scope :laip, :conditions => ["modulo_id = ?",MODULO_LAIP]
  scope :mensajes, :conditions => ["modulo_id = ?",MODULO_MENSAJES]

  def to_label
    nombre
  end

  def nombre_modulo
    MODULOS[self.modulo_id - 1][0]    
  end
end
