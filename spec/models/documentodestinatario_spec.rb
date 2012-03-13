require File.dirname(__FILE__) + '/../spec_helper'

describe Documentodestinatario do
  
  before(:each) do
    @documentodestinatario = Factory(:documentodestinatario)
  end
  
  it "debe ser valido" do
    @documentodestinatario.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: documentodestinatarios
#
#  id                 :integer         not null, primary key
#  documento_id       :integer         not null
#  copia_id           :integer
#  usuario_id         :integer         not null
#  original           :boolean         not null
#  documentoestado_id :integer         default(1), not null
#  institucion_id     :integer         not null
#  puesto             :string(255)
#  departamento       :string(255)
#

