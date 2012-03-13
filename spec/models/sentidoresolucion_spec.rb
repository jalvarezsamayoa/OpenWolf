require File.dirname(__FILE__) + '/../spec_helper'

describe Sentidoresolucion do
  
  before(:each) do
    @sentidoresolucion = Factory(:sentidoresolucion)
  end
  
  it "debe ser valido" do
    @sentidoresolucion.should be_valid
  end
  
  describe '#metodo' do
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: sentidosresolucion
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

