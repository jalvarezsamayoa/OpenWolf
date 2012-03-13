require File.dirname(__FILE__) + '/../spec_helper'

describe Profesion do
  
  before(:each) do
    @profesion = Factory(:profesion)
  end
  
  it "debe ser valido" do
    @profesion.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: profesiones
#
#  id         :integer         not null, primary key
#  nombre     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

