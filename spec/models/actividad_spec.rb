require File.dirname(__FILE__) + '/../spec_helper'

describe Actividad, :solr => true do

  fixtures :documentoclasificaciones

  before(:each) do
    @actividad = Factory.build(:actividad)
  end

  it "debe ser valido" do
    @actividad.should be_valid
  end

  describe '#marcar_como_terminada' do
    it 'cambiar el estado de actividad a TERMINADA' do
      @actividad.stub!(:save).and_return(true)
      @actividad.stub_chain(:solicitud, :actividad_terminada).and_return(true)

      @actividad.marcar_como_terminada()

      @actividad.estado_id.should == Actividad::ESTADO_COMPLETADA
      @actividad.fecha_resolucion.should == Date.today
    end
  end

end
# == Schema Information
#
# Table name: actividades
#
#  id               :integer         not null, primary key
#  institucion_id   :integer         not null
#  usuario_id       :integer         not null
#  fecha_asignacion :date            not null
#  textoactividad   :text            not null
#  estado_id        :integer         default(1), not null
#  fecha_resolucion :date
#  created_at       :datetime
#  updated_at       :datetime
#  solicitud_id     :integer         not null
#

