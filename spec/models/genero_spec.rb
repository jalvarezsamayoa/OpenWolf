require File.dirname(__FILE__) + '/../spec_helper'

describe Genero do
  
  before(:each) do
    @genero = Factory.build(:genero)
  end
  
  it "debe ser valido" do
    @genero.should be_valid
  end

  
end
# == Schema Information
#
# Table name: generos
#
#  id         :integer         not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

