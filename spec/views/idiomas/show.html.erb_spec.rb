require 'spec_helper'

describe "idiomas/show.html.erb" do
  before(:each) do
    @idioma = assign(:idioma, stub_model(Idioma,
      :nombre => "Nombre"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
  end
end
