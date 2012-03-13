require 'spec_helper'

describe Documentotraslado do
  pending "add some examples to (or delete) #{__FILE__}"
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

