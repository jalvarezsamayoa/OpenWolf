require File.dirname(__FILE__) + '/../spec_helper'

describe Tipomensaje do
  
  before(:each) do
    @tipomensaje = Factory(:tipomensaje)
  end
  
  it "debe ser valido" do
    @tipomensaje.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do      
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: tipomensajes
#
#  id         :integer         not null, primary key
#  nombre     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

