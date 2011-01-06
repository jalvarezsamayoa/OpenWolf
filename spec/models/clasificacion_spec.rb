require File.dirname(__FILE__) + '/../spec_helper'

describe Clasificacion do
  
  before(:each) do
    @clasificacion = Factory(:clasificacion)
  end
  
  it "debe ser valido" do
    @clasificacion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
