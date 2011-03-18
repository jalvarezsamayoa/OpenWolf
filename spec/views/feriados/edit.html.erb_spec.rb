require 'spec_helper'

describe "feriados/edit.html.erb" do
  before(:each) do
    @feriado = assign(:feriado, stub_model(Feriado,
      :nombre => "MyString",
      :dia => 1,
      :mes => 1,
      :institucion_id => 1,
      :tipoferiado_id => 1
    ))
  end

  it "renders the edit feriado form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feriados_path(@feriado), :method => "post" do
      assert_select "input#feriado_nombre", :name => "feriado[nombre]"
      assert_select "input#feriado_dia", :name => "feriado[dia]"
      assert_select "input#feriado_mes", :name => "feriado[mes]"
      assert_select "input#feriado_institucion_id", :name => "feriado[institucion_id]"
      assert_select "input#feriado_tipoferiado_id", :name => "feriado[tipoferiado_id]"
    end
  end
end
