class Seguimiento < ActiveRecord::Base
  versioned
  
  before_create :completar_informacion
  
  belongs_to :actividad
  belongs_to :institucion
  belongs_to :usuario

  has_many :documentos, :as => :proceso
    
  private

  def completar_informacion
    self.institucion_id = self.usuario.institucion_id
    self.fecha_creacion = Date.today    
  end
  
end
