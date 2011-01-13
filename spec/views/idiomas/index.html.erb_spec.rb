require 'spec_helper'

describe "idiomas/index.html.erb" do
  before(:each) do
    assign(:idiomas, [
      stub_model(Idioma,
        :nombre => "Nombre"
      ),
      stub_model(Idioma,
        :nombre => "Nombre"
      )
    ])
  end

  it "renders a list of idiomas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
  end
end
