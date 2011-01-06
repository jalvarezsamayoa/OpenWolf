require File.dirname(__FILE__) + '/../spec_helper'

describe Genero do
  
  before(:each) do
    @genero = Factory(:genero)
  end
  
  it "debe ser valido" do
    @genero.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
