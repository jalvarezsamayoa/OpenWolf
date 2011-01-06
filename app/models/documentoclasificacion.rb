class Documentoclasificacion < ActiveRecord::Base
  versioned
  
  SOLICITUDINFOPUBLICA = '9001'
  
  has_many :documentos
  belongs_to :documentocategoria

  validates_presence_of :nombre, :codigo
  validates_uniqueness_of :codigo
  validates_uniqueness_of :nombre, :scope => :documentocategoria_id

  default_scope :include => :documentocategoria, :order => :nombre

  def to_label
    nombre
  end
end
