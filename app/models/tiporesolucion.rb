class Tiporesolucion < ActiveRecord::Base
  TIPO_PRORROGA = 4
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

  scope :prorroga, where("id = ?",TIPO_PRORROGA)

  def to_label
    nombre
  end
end
