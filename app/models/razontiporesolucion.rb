class Razontiporesolucion < ActiveRecord::Base
  versioned
  validates_presence_of :nombre
  validates_uniqueness_of :nombre, :scope => :tiporesolucion_id

  belongs_to :tiporesolucion

  def to_label
    nombre
  end
end
