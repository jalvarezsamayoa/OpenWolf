class Tiporesolucion < ActiveRecord::Base
  versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  has_many :resoluciones
  has_many :razonestiposresoluciones
  belongs_to :estado

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      where("tiporesoluciones.nombre like ?", "%#{nombre}%" )
   end
  }

  def to_label
    nombre
  end
end
