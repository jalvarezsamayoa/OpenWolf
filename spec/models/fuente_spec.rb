require File.dirname(__FILE__) + '/../spec_helper'

describe Fuente do
  
  before(:each) do
    @fuente = Factory(:fuente)
  end
  
  it "debe ser valido" do
    @fuente.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
