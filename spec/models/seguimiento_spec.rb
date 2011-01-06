require File.dirname(__FILE__) + '/../spec_helper'

describe Seguimiento do
  
  before(:each) do
    @seguimiento = Factory(:seguimiento)
  end
  
  it "debe ser valido" do
    @seguimiento.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
