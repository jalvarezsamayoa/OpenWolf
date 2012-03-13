class Adjunto < ActiveRecord::Base
  
  belongs_to :proceso, :polymorphic => true
  belongs_to :usuario
  
  has_attached_file :archivo,
  :url => "/adjuntos/:id/download",  
  :path => ":rails_root/public/system/assets/adjuntos/:id/:basename.:extension"  

  validates_presence_of :numero, :message => "Debe incluir un numero de adjunto."
    
  validates_attachment_presence :archivo
  validates_attachment_size :archivo, :less_than => 5.megabytes

  def puede_descargar?(user = nil)
    # no puede descargar si no esta autenticado y no es infomracion
    # publica
    return false if ( user.nil? and self.informacion_publica == false )
    
    # no pude descargar si no es infomracin publica
    # y el usuario no tiene privilegios de Jed de UDIP
    return false if ( self.informacion_publica == false and !user.has_role?(:superudip))
    #
    return true
  end
  
end
# == Schema Information
#
# Table name: adjuntos
#
#  id                   :integer         not null, primary key
#  numero               :string(255)     not null
#  observaciones        :text
#  usuario_id           :integer         not null
#  proceso_id           :integer         not null
#  proceso_type         :string(255)     not null
#  created_at           :datetime
#  updated_at           :datetime
#  archivo_file_name    :string(255)
#  archivo_content_type :string(255)
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#  informacion_publica  :boolean         default(TRUE), not null
#

