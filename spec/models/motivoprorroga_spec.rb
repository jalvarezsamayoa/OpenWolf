require File.dirname(__FILE__) + '/../spec_helper'

describe Motivoprorroga do
  
  before(:each) do
    @motivoprorroga = Factory(:motivoprorroga)
  end
  
  it "debe ser valido" do
    @motivoprorroga.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
