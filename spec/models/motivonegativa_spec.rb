require File.dirname(__FILE__) + '/../spec_helper'

describe Motivonegativa do
  
  before(:each) do
    @motivonegativa = Factory(:motivonegativa)
  end
  
  it "debe ser valido" do
    @motivonegativa.should be_valid
  end
  
end
