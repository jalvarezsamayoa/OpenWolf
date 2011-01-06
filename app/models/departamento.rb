class Departamento < ActiveRecord::Base
  versioned
  
  validates :nombre, :presence => true, :uniqueness => true
  validates :abreviatura, :presence => true, :uniqueness => true
  has_many :municipios, :dependent => :destroy

  default_scope :order => :nombre

  def to_label
    nombre
  end
end
