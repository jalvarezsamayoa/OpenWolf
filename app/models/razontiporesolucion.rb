class Razontiporesolucion < ActiveRecord::Base
  versioned
  validates_presence_of :nombre
  validates_uniqueness_of :nombre, :scope => :tiporesolucion_id

  belongs_to :tiporesolucion

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("razonresoluciones.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end
end
