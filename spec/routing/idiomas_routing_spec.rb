require "spec_helper"

describe IdiomasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/idiomas" }.should route_to(:controller => "idiomas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/idiomas/new" }.should route_to(:controller => "idiomas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/idiomas/1" }.should route_to(:controller => "idiomas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/idiomas/1/edit" }.should route_to(:controller => "idiomas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/idiomas" }.should route_to(:controller => "idiomas", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/idiomas/1" }.should route_to(:controller => "idiomas", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/idiomas/1" }.should route_to(:controller => "idiomas", :action => "destroy", :id => "1")
    end

  end
end
