require 'spec_helper'

describe "documentotraslados/show.html.erb" do
  before(:each) do
    @documentotraslado = assign(:documentotraslado, stub_model(Documentotraslado,
      :institucion_id => 1,
      :usuario_id => 1,
      :destinatario_id => 1,
      :documento_id => 1,
      :documento_destinatario_id => 1,
      :original => false,
      :estado_entrega_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
