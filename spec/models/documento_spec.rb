require File.dirname(__FILE__) + '/../spec_helper'

describe Documento do
  
  before(:each) do
    @documento = Factory(:documento)
  end
  
  it "debe ser valido" do
    @documento.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: documentos
#
#  id                        :integer         not null, primary key
#  numero                    :string(255)     not null
#  origen_id                 :integer         default(1), not null
#  documentoclasificacion_id :integer         not null
#  documentocategoria_id     :integer         not null
#  fecha_documento           :date            not null
#  autor_id                  :integer         not null
#  asunto                    :string(255)     not null
#  texto                     :text
#  fecha_recepcion           :date
#  remitente_nombre          :string(255)
#  remitente_direccion       :text
#  remitente_telefonos       :string(255)
#  remitente_email           :string(255)
#  estado_envio_id           :integer         default(1), not null
#  original                  :boolean         not null
#  usuario_id                :integer         not null
#  institucion_id            :integer         not null
#  parent_id                 :integer
#  lft                       :integer
#  rgt                       :integer
#  created_at                :datetime
#  updated_at                :datetime
#  archivo_id                :integer
#

