class TempAsset < ActiveRecord::Base

  belongs_to :institucion
  
   has_attached_file :archivo,
  :path => ":rails_root/public/system/assets/tmpassets/:id/:basename.:extension"

  def importar_archivo
    self.send_later(:importar)
  end

  def importar
    h = Herramienta.new
    
    opciones = {:file => self.archivo.to_file,
      :campos => Marshal.load(self.options),
      :usuario_id => self.usuario_id,
      :institucion_id => self.institucion_id }
    
    h.importar_solicitudes(opciones)
  end
end
# == Schema Information
#
# Table name: temp_assets
#
#  id                   :integer         not null, primary key
#  institucion_id       :integer
#  usuario_id           :integer
#  options              :text
#  created_at           :datetime
#  updated_at           :datetime
#  archivo_file_name    :string(255)
#  archivo_content_type :string(255)
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#

