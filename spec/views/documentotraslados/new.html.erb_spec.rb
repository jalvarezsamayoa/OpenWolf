require 'spec_helper'

describe "documentotraslados/new.html.erb" do
  before(:each) do
    assign(:documentotraslado, stub_model(Documentotraslado,
      :institucion_id => 1,
      :usuario_id => 1,
      :destinatario_id => 1,
      :documento_id => 1,
      :documento_destinatario_id => 1,
      :original => false,
      :estado_entrega_id => 1
    ).as_new_record)
  end

  it "renders new documentotraslado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => documentotraslados_path, :method => "post" do
      assert_select "input#documentotraslado_institucion_id", :name => "documentotraslado[institucion_id]"
      assert_select "input#documentotraslado_usuario_id", :name => "documentotraslado[usuario_id]"
      assert_select "input#documentotraslado_destinatario_id", :name => "documentotraslado[destinatario_id]"
      assert_select "input#documentotraslado_documento_id", :name => "documentotraslado[documento_id]"
      assert_select "input#documentotraslado_documento_destinatario_id", :name => "documentotraslado[documento_destinatario_id]"
      assert_select "input#documentotraslado_original", :name => "documentotraslado[original]"
      assert_select "input#documentotraslado_estado_entrega_id", :name => "documentotraslado[estado_entrega_id]"
    end
  end
end
