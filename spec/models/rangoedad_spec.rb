require File.dirname(__FILE__) + '/../spec_helper'

describe Rangoedad do
  
  before(:each) do
    @rangoedad = Factory(:rangoedad)
  end
  
  it "debe ser valido" do
    @rangoedad.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
