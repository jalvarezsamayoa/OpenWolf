require File.dirname(__FILE__) + '/../spec_helper'

describe Adjunto do
  
  before(:each) do
    @adjunto = Factory(:adjunto)
  end
  
  it "debe ser valido" do
    @adjunto.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
