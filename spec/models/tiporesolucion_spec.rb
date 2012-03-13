require File.dirname(__FILE__) + '/../spec_helper'

describe Tiporesolucion do
  
  before(:each) do
    @tiporesolucion = Factory(:tiporesolucion)
  end
  
  it "debe ser valido" do
    @tiporesolucion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: tiposresoluciones
#
#  id                           :integer         not null, primary key
#  nombre                       :string(255)     not null
#  actualiza_fecha              :boolean         default(FALSE)
#  estado_id                    :integer         default(1), not null
#  created_at                   :datetime
#  updated_at                   :datetime
#  actualiza_fecha_notificacion :boolean         default(FALSE)
#  positiva                     :boolean         default(FALSE)
#  aliaspdh                     :string(255)
#

