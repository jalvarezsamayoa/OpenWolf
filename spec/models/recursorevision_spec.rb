require File.dirname(__FILE__) + '/../spec_helper'

describe Recursorevision do
  
  before(:each) do
    @recurso = Factory(:recursorevision)
  end
  
  it "debe ser valido" do
    @recurso.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
