require File.dirname(__FILE__) + '/../spec_helper'

describe Tiporesolucion do
  
  before(:each) do
    @tiporesolucion = Factory(:tiporesolucion)
  end
  
  it "debe ser valido" do
    @tiporesolucion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
