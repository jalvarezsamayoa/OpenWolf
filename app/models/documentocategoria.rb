class Documentocategoria < ActiveRecord::Base
  versioned
  acts_as_nested_set

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("documentocategorias.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end
end
