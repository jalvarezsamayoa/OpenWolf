require File.dirname(__FILE__) + '/../spec_helper'

describe Razontiporesolucion do
  
  before(:each) do
    @razontiporesolucion = Factory(:razontiporesolucion)
  end
  
  it "debe ser valido" do
    @razontiporesolucion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
