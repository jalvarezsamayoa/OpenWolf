require File.dirname(__FILE__) + '/../spec_helper'

describe Motivonegativa do
  
  before(:each) do
    @motivonegativa = Factory(:motivonegativa)
  end
  
  it "debe ser valido" do
    @motivonegativa.should be_valid
  end
  
end
# == Schema Information
#
# Table name: motivosnegativa
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

