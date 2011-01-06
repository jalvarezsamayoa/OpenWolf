require File.dirname(__FILE__) + '/../spec_helper'

describe Actividad do
  
  before(:each) do
    @actividad = Factory(:actividad)
  end

  it { should validate_presence_of(:usuario_id) }
  it { should validate_presence_of(:institucion_id) }
  it { should validate_presence_of(:textoactividad) }

  it { should belong_to(:solicitud) }
  it { should belong_to(:usuario) }
  it { should belong_to(:institucion) }
  it { should belong_to(:estado) }

  it { should have_many(:seguimientos, :dependent => :destroy) }
    
  it "debe ser valido" do
    @actividad.should be_valid
  end
  
  describe '#marcar_como_terminada' do    
    it 'debe hacer algo' do
      pending
    end    
  end

  describe '#notificar_asignacion' do    
    it 'debe enviar email' do
      pending
    end    
  end

  describe '#actualizar_solicitud' do    
    it 'actualiza estado de solicitud padre ' do
      pending
    end    
  end

  describe '#completar_infomracion' do    
    it 'completa informacion predeterminada al crear una nueva actividad' do
      pending
    end    
  end
  
end
