require File.dirname(__FILE__) + '/../spec_helper'

describe Recursorevision do
  
  before(:each) do
    @recurso = Factory(:recursorevision)
  end
  
  it "debe ser valido" do
    @recurso.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: recursosrevision
#
#  id                        :integer         not null, primary key
#  solicitud_id              :integer
#  fecha_presentacion        :date
#  fecha_notificacion        :date
#  fecha_resolucion          :date
#  descripcion               :text
#  sentidoresolucion_id      :integer
#  institucion_id            :integer
#  usuario_id                :integer
#  created_at                :datetime
#  updated_at                :datetime
#  numero                    :string(255)
#  documentoclasificacion_id :integer         default(3)
#

