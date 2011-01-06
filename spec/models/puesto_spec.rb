require File.dirname(__FILE__) + '/../spec_helper'

describe Puesto do
  
  before(:each) do
    @puesto = Factory(:puesto)
  end
  
  it "debe ser valido" do
    @puesto.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
