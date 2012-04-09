class Estado < ActiveRecord::Base
  #versioned
  
  MODULOS = [['LAIP',1],['MENSAJES',2]]
  MODULO_LAIP = 1
  MODULO_MENSAJES = 2

  validates :nombre, :presence => true, :uniqueness => true
   
  has_many :solicitudes
  has_many :tiporesoluciones

  scope :laip, :conditions => ["modulo_id = ?",MODULO_LAIP]
  scope :mensajes, :conditions => ["modulo_id = ?",MODULO_MENSAJES]

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("estados.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end

  def nombre_modulo
    MODULOS[self.modulo_id - 1][0]    
  end
end
# == Schema Information
#
# Table name: estados
#
#  id             :integer         not null, primary key
#  nombre         :string(255)     not null
#  created_at     :datetime
#  updated_at     :datetime
#  final          :boolean         default(FALSE)
#  puede_entregar :boolean         default(FALSE)
#  modulo_id      :integer         default(1)
#

