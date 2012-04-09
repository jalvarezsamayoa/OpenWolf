class Busqueda
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :institucion_id, :fecha_desde, :fecha_hasta, :q, \
  :solicitud_via, :solicitud_estado, :solicitud_tiempo, :filtrar
  
  def initialize(*args)
    super
    self.fecha_desde = (Date.today - Date.today.yday + 1)
    self.fecha_hasta = Date.today    
  end
 
  def persisted? ; false ; end;
  
end
