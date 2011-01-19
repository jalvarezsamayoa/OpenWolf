require 'spec_helper'

describe "archivos/edit.html.erb" do
  before(:each) do
    @archivo = assign(:archivo, stub_model(Archivo,
      :nombre => "MyString",
      :institucion_id => 1
    ))
  end

  it "renders the edit archivo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => archivo_path(@archivo), :method => "post" do
      assert_select "input#archivo_nombre", :name => "archivo[nombre]"
      assert_select "input#archivo_institucion_id", :name => "archivo[institucion_id]"
    end
  end
end
