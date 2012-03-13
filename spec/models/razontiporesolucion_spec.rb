require File.dirname(__FILE__) + '/../spec_helper'

describe Razontiporesolucion do
  
  before(:each) do
    @razontiporesolucion = Factory(:razontiporesolucion)
  end
  
  it "debe ser valido" do
    @razontiporesolucion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: razonestiposresoluciones
#
#  id                  :integer         not null, primary key
#  nombre              :string(255)     not null
#  tiporesolucion_id   :integer         not null
#  created_at          :datetime
#  updated_at          :datetime
#  informacion_publica :boolean         default(TRUE), not null
#

