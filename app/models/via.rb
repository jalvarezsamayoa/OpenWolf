class Via < ActiveRecord::Base
  versioned
  
  validates :nombre, :presence => true, :uniqueness => true

   scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("vias.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end
  
end
