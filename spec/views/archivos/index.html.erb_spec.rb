require 'spec_helper'

describe "archivos/index.html.erb" do
  before(:each) do
    assign(:archivos, [
      stub_model(Archivo,
        :nombre => "Nombre",
        :institucion_id => 1
      ),
      stub_model(Archivo,
        :nombre => "Nombre",
        :institucion_id => 1
      )
    ])
  end

  it "renders a list of archivos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
