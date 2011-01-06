require File.dirname(__FILE__) + '/../spec_helper'

describe Municipio do

  before(:each) do
    @muni = Factory.create(:municipio)
  end

  it { should validate_presence_of(:nombre) }
  it { should validate_uniqueness_of(:nombre) }

  it "es valido" do
    @muni.should be_valid
  end

  it "es invalido" do
    @muni.nombre = nil
    @muni.departamento = nil
    @muni.should_not be_valid
  end

  describe 'asociaciones' do
    it { should belong_to(:departamento) }    
  end

  describe '#nombre_completo' do
    it "debe retornar nombre y departamento" do
      @muni.nombre = "Muni"
      @muni.departamento.nombre = "Depto"
      @muni.nombre_completo.should == "Muni, Depto"       
    end
  end
  
  
end
