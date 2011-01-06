class Rangoedad < ActiveRecord::Base
  versioned
  
  validates_presence_of :nombre
  validates_uniqueness_of :nombre
  
  has_many :solicitudes

  default_scope :order => :nombre

  def to_label
    nombre
  end
end
