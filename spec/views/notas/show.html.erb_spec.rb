require 'spec_helper'

describe "notas/show.html.erb" do
  before(:each) do
    @nota = assign(:nota, stub_model(Nota,
      :proceso_id => 1,
      :proceso_type => "Proceso Type",
      :usuario_id => 1,
      :texto => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Proceso Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
