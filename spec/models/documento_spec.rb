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
