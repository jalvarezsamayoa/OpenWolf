class Tipomensaje < ActiveRecord::Base  
  has_many :mensajes
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  def to_label
    nombre
  end
end
