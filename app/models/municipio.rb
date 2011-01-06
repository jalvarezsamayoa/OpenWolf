class Municipio < ActiveRecord::Base
  versioned
  
  belongs_to :departamento
  
  validates :nombre, :presence => true, :uniqueness => true
  validates_associated :departamento, :message=>'El Departamento relacionado no es valido.'

  default_scope :include => :departamento, :order => "departamentos.nombre, municipios.nombre"

  def nombre_completo
    return nombre + ', ' + departamento.nombre
  end

  def to_label
   nombre
  end
  
end
