require File.dirname(__FILE__) + '/../spec_helper'

describe Via do
  before(:each) do
    @via = Factory.create(:via)
  end
  
  it { should validate_presence_of(:nombre) }
  it { should validate_uniqueness_of(:nombre)  } 
  
  it "es valido" do
    @via.should be_valid
  end

  it "es invalido" do
    @via.nombre = nil
    @via.should_not be_valid
  end

  
end
# == Schema Information
#
# Table name: vias
#
#  id         :integer         not null, primary key
#  nombre     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

