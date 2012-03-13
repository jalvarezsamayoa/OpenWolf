class Documentotraslado < ActiveRecord::Base
  belongs_to :institucion #del documento
  belongs_to :usuario #quien genero el traslado
  belongs_to :destinatario, :class_name => "Usuario", :foreign_key => "destinatario_id"
  belongs_to :documento #original que se traslada
  belongs_to :documentodestino, :class_name => "Documento", :foreign_key => "documento_destinatario_id"

  before_create :crear_documento

  #creamos el documento que se traslada
  def crear_documento
    old_doc =  self.documento

    n = Documento.where('documentos.numero like ?','%'+old_doc.numero+'%').count
    
    n = n + 1 if n > 1

    old_doc.numero = old_doc.numero + '-' + n.to_s.rjust(3,'0')
    old_doc.original = self.original

  
    new_doc =  Documento.new( old_doc.attributes )
    
    new_doc.save!

    new_doc.move_to_child_of(old_doc)

    self.documento_destinatario_id = new_doc.id
  end
end
# == Schema Information
#
# Table name: documentotraslados
#
#  id                        :integer         not null, primary key
#  institucion_id            :integer         not null
#  usuario_id                :integer         not null
#  destinatario_id           :integer         not null
#  documento_id              :integer         not null
#  documento_destinatario_id :integer         not null
#  original                  :boolean         default(FALSE)
#  estado_entrega_id         :integer         default(1), not null
#  fecha_envio               :datetime
#  fecha_respuesta           :datetime
#  created_at                :datetime
#  updated_at                :datetime
#  descripcion               :text
#

