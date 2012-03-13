require File.dirname(__FILE__) + '/../spec_helper'

describe Fuente do
  
  before(:each) do
    @fuente = Factory.build(:fuente)
  end
  
  it "debe ser valido" do
    @fuente.should be_valid
  end
  
  
end
# == Schema Information
#
# Table name: fuentes
#
#  id         :integer         not null, primary key
#  nombre     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

