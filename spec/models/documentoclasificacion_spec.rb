require File.dirname(__FILE__) + '/../spec_helper'

describe Documentoclasificacion do
  
  before(:each) do
    @documentoclasificacion = Factory.build(:documentoclasificacion)
  end
  
  it "debe ser valido" do
    @documentoclasificacion.should be_valid
  end
 
  
end
