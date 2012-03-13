require File.dirname(__FILE__) + '/../spec_helper'

describe Adjunto do

  before(:each) do
    @adjunto = Factory.build(:adjunto)
  end

  it "debe ser valido" do
    @adjunto.should be_valid
  end

  describe '#puede_descargar?' do
    context "debe ser falso" do

      it 'cuando no hay usuario y la informacion no es publica' do
        @adjunto.informacion_publica = false
        @adjunto.puede_descargar?(nil).should == false
      end

      it "cuando no es informacion publica y usuario no es jefe de udip" do
        usuario = mock_model(Usuario)
        usuario.stub!(:has_role?).and_return(false)
        @adjunto.informacion_publica = false
        @adjunto.puede_descargar?(usuario).should == false
      end

    end

    context "debe ser verdadero" do
      it "cuando no es informacion publica pero el usuario es jefe de la udip" do
        usuario = mock_model(Usuario)
        usuario.stub!(:has_role?).and_return(true)
        @adjunto.informacion_publica = false
        @adjunto.puede_descargar?(usuario).should == true
      end

      it "cuando es informacion publica y no hay usuario" do
        @adjunto.informacion_publica = true
        @adjunto.puede_descargar?(nil).should == true
      end

      it "cuando es informacion publica y hay usuario" do
        usuario = mock_model(Usuario)
        @adjunto.informacion_publica = true
        @adjunto.puede_descargar?(usuario).should == true
      end

    end
  end

end
# == Schema Information
#
# Table name: adjuntos
#
#  id                   :integer         not null, primary key
#  numero               :string(255)     not null
#  observaciones        :text
#  usuario_id           :integer         not null
#  proceso_id           :integer         not null
#  proceso_type         :string(255)     not null
#  created_at           :datetime
#  updated_at           :datetime
#  archivo_file_name    :string(255)
#  archivo_content_type :string(255)
#  archivo_file_size    :integer
#  archivo_updated_at   :datetime
#  informacion_publica  :boolean         default(TRUE), not null
#

