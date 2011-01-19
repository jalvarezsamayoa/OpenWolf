require 'spec_helper'

describe "documentotraslados/index.html.erb" do
  before(:each) do
    assign(:documentotraslados, [
      stub_model(Documentotraslado,
        :institucion_id => 1,
        :usuario_id => 1,
        :destinatario_id => 1,
        :documento_id => 1,
        :documento_destinatario_id => 1,
        :original => false,
        :estado_entrega_id => 1
      ),
      stub_model(Documentotraslado,
        :institucion_id => 1,
        :usuario_id => 1,
        :destinatario_id => 1,
        :documento_id => 1,
        :documento_destinatario_id => 1,
        :original => false,
        :estado_entrega_id => 1
      )
    ])
  end

  it "renders a list of documentotraslados" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
