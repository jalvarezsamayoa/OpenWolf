require File.dirname(__FILE__) + '/../spec_helper'

describe Solicitud do
  
  before(:each) do
    @solicitud = Factory(:solicitud)
  end
  
  it "debe ser valido" do
    @solicitud.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end


  describe '#es_pertinente?' do   
    it 'true si usuario esta relacionado a solicitud' do
      pending
    end

    it "true si usuario pertenece a unidad de informacion" do
      pending
    end

    it "false si usuario no esta relacionado a solicitud" do
      pending
    end

    it "false si usuario no pertenece a unidad de informacion" do
      pending
    end    
  end

  
end
