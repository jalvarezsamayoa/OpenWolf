class Fuente < ActiveRecord::Base
  versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

   scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("fuentes.nombre like ?", "%#{nombre}%" )
   end
  }
end
