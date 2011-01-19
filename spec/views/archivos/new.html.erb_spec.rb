require 'spec_helper'

describe "archivos/new.html.erb" do
  before(:each) do
    assign(:archivo, stub_model(Archivo,
      :nombre => "MyString",
      :institucion_id => 1
    ).as_new_record)
  end

  it "renders new archivo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => archivos_path, :method => "post" do
      assert_select "input#archivo_nombre", :name => "archivo[nombre]"
      assert_select "input#archivo_institucion_id", :name => "archivo[institucion_id]"
    end
  end
end
