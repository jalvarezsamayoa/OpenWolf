class Profesion < ActiveRecord::Base
  versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  has_many :solicitudes

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(profesiones.nombre) like ?", valor )
   end
  }

  def to_label
    nombre
  end
  
end
