require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Idioma do
  before(:each) do
    @idioma = Factory.build(:idioma)
  end
  
  it "debe ser valido" do
    @idioma.should be_valid    
  end
  
end

