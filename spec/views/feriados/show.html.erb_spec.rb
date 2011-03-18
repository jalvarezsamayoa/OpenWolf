require 'spec_helper'

describe "feriados/show.html.erb" do
  before(:each) do
    @feriado = assign(:feriado, stub_model(Feriado,
      :nombre => "Nombre",
      :dia => 1,
      :mes => 1,
      :institucion_id => 1,
      :tipoferiado_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
