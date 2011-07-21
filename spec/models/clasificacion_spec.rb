require File.dirname(__FILE__) + '/../spec_helper'

describe Clasificacion do
  
  before(:each) do
    @clasificacion = Factory.build(:clasificacion)
  end
  
  it "debe ser valido" do
    @clasificacion.should be_valid
  end
  
   
end
