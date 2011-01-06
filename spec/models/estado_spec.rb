require File.dirname(__FILE__) + '/../spec_helper'

describe Estado do
  before(:each) do
    @estado = Factory.create(:estado)
  end
  
  it { should validate_presence_of(:nombre) }
  it { should validate_uniqueness_of(:nombre)  }
   
  it "es valido" do
    @estado.should be_valid
  end

  it "es invalido" do
    @estado.nombre = nil
    @estado.should_not be_valid
  end

  describe 'asociaciones' do
    it { should have_many(:solicitudes) }
    it { should have_many(:tiporesoluciones) }
  end

  it "#nombre_modulo debe retornar el nombre del modulo actual" do
    @estado.nombre_modulo.should == 'LAIP'
  end
  
end
