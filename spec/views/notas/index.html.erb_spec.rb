require 'spec_helper'

describe "notas/index.html.erb" do
  before(:each) do
    assign(:notas, [
      stub_model(Nota,
        :proceso_id => 1,
        :proceso_type => "Proceso Type",
        :usuario_id => 1,
        :texto => "MyText"
      ),
      stub_model(Nota,
        :proceso_id => 1,
        :proceso_type => "Proceso Type",
        :usuario_id => 1,
        :texto => "MyText"
      )
    ])
  end

  it "renders a list of notas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Proceso Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
