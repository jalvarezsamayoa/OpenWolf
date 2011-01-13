require 'spec_helper'

describe "idiomas/new.html.erb" do
  before(:each) do
    assign(:idioma, stub_model(Idioma,
      :nombre => "MyString"
    ).as_new_record)
  end

  it "renders new idioma form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => idiomas_path, :method => "post" do
      assert_select "input#idioma_nombre", :name => "idioma[nombre]"
    end
  end
end
