require File.dirname(__FILE__) + '/../spec_helper'

describe Institucion do
  
  before(:each) do
    @institucion = Factory(:institucion)
  end
  
  it "debe ser valido" do
    @institucion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
