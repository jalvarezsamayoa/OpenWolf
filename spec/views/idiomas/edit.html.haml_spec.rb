require 'spec_helper'

describe "idiomas/edit.html.haml" do
  before(:each) do
    @idioma = assign(:idioma, stub_model(Idioma,
      :nombre => "MyString"
    ))
  end

  it "renders the edit idioma form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => idioma_path(@idioma), :method => "post" do
      assert_select "input#idioma_nombre", :name => "idioma[nombre]"
    end
  end
end
