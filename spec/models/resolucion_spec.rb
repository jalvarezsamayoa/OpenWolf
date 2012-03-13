require File.dirname(__FILE__) + '/../spec_helper'

describe Resolucion do
  
  before(:each) do
    @resolucion = Factory(:resolucion)
  end
  
  it "debe ser valido" do
    @resolucion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: resoluciones
#
#  id                        :integer         not null, primary key
#  numero                    :string(255)     not null
#  solicitud_id              :integer         not null
#  usuario_id                :integer         not null
#  institucion_id            :integer         not null
#  descripcion               :text            not null
#  tiporesolucion_id         :integer         not null
#  razontiporesolucion_id    :integer         not null
#  nueva_fecha               :date
#  created_at                :datetime
#  updated_at                :datetime
#  informacion_publica       :boolean         default(TRUE), not null
#  documentoclasificacion_id :integer         default(2)
#  fecha                     :date
#  fecha_notificacion        :date
#

