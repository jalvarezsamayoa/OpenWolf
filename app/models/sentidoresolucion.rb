class Sentidoresolucion < ActiveRecord::Base
  versioned
  
  has_many :recursosrevision

  def to_label
    nombre
  end
end
