class Adjunto < ActiveRecord::Base
  
  belongs_to :proceso, :polymorphic => true
  
  has_attached_file :archivo,
  :url => "/adjuntos/:id/download",  
  :path => ":rails_root/public/system/assets/adjuntos/:id/:basename.:extension"  

  validates_presence_of :numero, :message => "Debe incluir un numero de adjunto."
  validates_uniqueness_of :numero, :message=>"Valor de Numero de Adjunto ya esta en uso."
  
  validates_attachment_presence :archivo
  validates_attachment_size :archivo, :less_than => 5.megabytes

  def puede_descargar?(usuario = nil)
    # no puede descargar si no esta autenticado y no es infomracion publica
    return false if ( usuario == nil and self.informacion_publica == false )
    # no pude descargar si no es infomracin publica
    # y el usuario no tiene privilegios de Jed de UDIP
    return false if ( self.informacion_publica == false and !usuario.has_role?(:superudip))
    #
    return true
  end
  
end
