class Recursorevision < ActiveRecord::Base
  versioned
  
  belongs_to :solicitud
  belongs_to :usuario
  belongs_to :institucion
  belongs_to :sentidoresolucion

  validates_presence_of :fecha_presentacion, :descripcion

  before_validation(:on => :create) do
    cleanup
  end

  def nuevo_numero
    i = Recursorevision.count(:conditions => ["institucion_id = ? and date_part(\'year\',created_at) = ?", self.institucion_id, Date.today.year ] ).to_i + 1
    
    self.numero = self.institucion.codigo + '-03-' +  Date.today.year.to_s + '-' + i.to_s.rjust(6,'0')
  end
  
  def cleanup
    self.institucion_id = self.usuario.institucion_id
    self.numero = self.nuevo_numero if (self.numero.nil? or self.numero.empty?)
  end
end
