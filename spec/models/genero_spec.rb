require File.dirname(__FILE__) + '/../spec_helper'

describe Genero do
  
  before(:each) do
    @genero = Factory.build(:genero)
  end
  
  it "debe ser valido" do
    @genero.should be_valid
  end

  
end
