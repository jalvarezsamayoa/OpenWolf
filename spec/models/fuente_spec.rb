require File.dirname(__FILE__) + '/../spec_helper'

describe Fuente do
  
  before(:each) do
    @fuente = Factory.build(:fuente)
  end
  
  it "debe ser valido" do
    @fuente.should be_valid
  end
  
  
end
