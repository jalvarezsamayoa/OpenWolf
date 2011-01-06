require File.dirname(__FILE__) + '/../spec_helper'

describe Documentoclasificacion do
  
  before(:each) do
    @documentoclasificacion = Factory(:documentoclasificacion)
  end
  
  it "debe ser valido" do
    @documentoclasificacion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
