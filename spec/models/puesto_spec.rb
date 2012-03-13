require File.dirname(__FILE__) + '/../spec_helper'

describe Puesto do
  
  before(:each) do
    @puesto = Factory(:puesto)
  end
  
  it "debe ser valido" do
    @puesto.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: puestos
#
#  id             :integer         not null, primary key
#  nombre         :string(255)     not null
#  institucion_id :integer         not null
#  created_at     :datetime
#  updated_at     :datetime
#

