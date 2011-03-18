require 'spec_helper'

describe "feriados/index.html.erb" do
  before(:each) do
    assign(:feriados, [
      stub_model(Feriado,
        :nombre => "Nombre",
        :dia => 1,
        :mes => 1,
        :institucion_id => 1,
        :tipoferiado_id => 1
      ),
      stub_model(Feriado,
        :nombre => "Nombre",
        :dia => 1,
        :mes => 1,
        :institucion_id => 1,
        :tipoferiado_id => 1
      )
    ])
  end

  it "renders a list of feriados" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
