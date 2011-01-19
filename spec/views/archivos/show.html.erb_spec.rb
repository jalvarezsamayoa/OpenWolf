require 'spec_helper'

describe "archivos/show.html.erb" do
  before(:each) do
    @archivo = assign(:archivo, stub_model(Archivo,
      :nombre => "Nombre",
      :institucion_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
