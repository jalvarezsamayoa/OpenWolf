require File.dirname(__FILE__) + '/../spec_helper'

describe Seguimiento do
  
  before(:each) do
    @seguimiento = Factory(:seguimiento)
  end
  
  it "debe ser valido" do
    @seguimiento.should be_valid
  end
  
  describe '#metodo' do    
    it 'debe hacer algo' do
      pending
    end    
  end
  
end
# == Schema Information
#
# Table name: seguimientos
#
#  id                   :integer         not null, primary key
#  actividad_id         :integer         not null
#  institucion_id       :integer         not null
#  usuario_id           :integer         not null
#  fecha_creacion       :date            not null
#  textoseguimiento     :text            not null
#  created_at           :datetime
#  updated_at           :datetime
#  archivo_file_name    :string(255)
#  archivo_content_type :string(255)
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#  informacion_publica  :boolean         default(TRUE), not null
#

