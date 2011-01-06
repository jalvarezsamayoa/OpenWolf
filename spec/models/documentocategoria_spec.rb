require File.dirname(__FILE__) + '/../spec_helper'

describe Documentocategoria do
  
  before(:each) do
    @documentocategoria = Factory(:documentocategoria)
  end
  
  it "debe ser valido" do
    @documentocategoria.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
