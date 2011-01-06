class Tiporesolucion < ActiveRecord::Base
  versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  has_many :resoluciones
  has_many :razonestiposresoluciones
  belongs_to :estado

  def to_label
    nombre
  end
end
