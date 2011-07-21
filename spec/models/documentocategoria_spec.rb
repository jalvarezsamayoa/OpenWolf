require File.dirname(__FILE__) + '/../spec_helper'

describe Documentocategoria do
  
  before(:each) do
    @documentocategoria = Factory.build(:documentocategoria)
  end

  it { should validate_presence_of(:nombre) }
  it { @documentocategoria.save; should validate_uniqueness_of(:nombre, :scope => :parent_id) }
  
  it "debe ser valido" do
    @documentocategoria.should be_valid
  end
  
  
end
