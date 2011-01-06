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
