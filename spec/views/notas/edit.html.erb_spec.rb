require 'spec_helper'

describe "notas/edit.html.erb" do
  before(:each) do
    @nota = assign(:nota, stub_model(Nota,
      :proceso_id => 1,
      :proceso_type => "MyString",
      :usuario_id => 1,
      :texto => "MyText"
    ))
  end

  it "renders the edit nota form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => nota_path(@nota), :method => "post" do
      assert_select "input#nota_proceso_id", :name => "nota[proceso_id]"
      assert_select "input#nota_proceso_type", :name => "nota[proceso_type]"
      assert_select "input#nota_usuario_id", :name => "nota[usuario_id]"
      assert_select "textarea#nota_texto", :name => "nota[texto]"
    end
  end
end
