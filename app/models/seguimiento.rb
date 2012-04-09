class Seguimiento < ActiveRecord::Base
  #versioned
  
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
# == Schema Information
#
# Table name: seguimientos
#
#  id                   :integer         not null, primary key
#  actividad_id         :integer         not null
#  institucion_id       :integer         not null
#  usuario_id           :integer         not null
#  fecha_creacion       :date            not null
#  textoseguimiento     :text            not null
#  created_at           :datetime
#  updated_at           :datetime
#  archivo_file_name    :string(255)
#  archivo_content_type :string(255)
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#  informacion_publica  :boolean         default(TRUE), not null
#

