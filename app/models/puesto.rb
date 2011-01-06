class Puesto < ActiveRecord::Base  
  belongs_to :institucion

  validates_presence_of :nombre, :message=>"Campo Nombre no puede estar vacio."
  validates_uniqueness_of :nombre, :message=>"Nombre ya esta en uso.", :scope => :institucion_id

  validates_associated :institucion, :message=>'La Institucion relacionada no es valida.'

  default_scope :include => :institucion

  def nombre_completo
    return nombre.strip + ' en ' + institucion.nombre.strip
  end
end
