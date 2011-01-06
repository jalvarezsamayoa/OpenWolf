require File.dirname(__FILE__) + '/../spec_helper'

describe Tipomensaje do
  
  before(:each) do
    @tipomensaje = Factory(:tipomensaje)
  end
  
  it "debe ser valido" do
    @tipomensaje.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do      
      pending
    end    
  end
  
end
