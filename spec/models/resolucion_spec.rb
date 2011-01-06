require File.dirname(__FILE__) + '/../spec_helper'

describe Resolucion do
  
  before(:each) do
    @resolucion = Factory(:resolucion)
  end
  
  it "debe ser valido" do
    @resolucion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
