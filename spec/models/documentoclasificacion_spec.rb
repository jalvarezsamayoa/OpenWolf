require File.dirname(__FILE__) + '/../spec_helper'

describe Documentoclasificacion do
  
  before(:each) do
    @documentoclasificacion = Factory.build(:documentoclasificacion)
  end
  
  it "debe ser valido" do
    @documentoclasificacion.should be_valid
  end
 
  
end
# == Schema Information
#
# Table name: documentoclasificaciones
#
#  id                    :integer         not null, primary key
#  nombre                :string(255)
#  documentocategoria_id :integer
#  codigo                :string(255)
#  plantilla             :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

