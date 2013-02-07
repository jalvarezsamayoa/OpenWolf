class Municipio < ActiveRecord::Base
  #versioned
  
  belongs_to :departamento
  
  validates :nombre, :presence => true, :uniqueness => true
  validates_associated :departamento, :message=>'El Departamento relacionado no es valido.'

  default_scope :include => :departamento, :order => "departamentos.nombre, municipios.nombre"

  scope :nombre_like, lambda { |nombre|
    unless nombre.nil? || nombre.empty? || nombre.first.nil?
      valor = "%#{nombre}%".upcase
      where("UPPER(municipios.nombre) like ? or UPPER(departamentos.nombre) like ?", valor, valor )
   end
  }

  def nombre_completo
    return nombre + ', ' + departamento.nombre
  end

  def to_label
   nombre
  end
  
end
# == Schema Information
#
# Table name: municipios
#
#  id              :integer         not null, primary key
#  nombre          :string(255)     not null
#  departamento_id :integer         not null
#  created_at      :datetime
#  updated_at      :datetime
#

