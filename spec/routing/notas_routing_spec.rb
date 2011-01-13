require "spec_helper"

describe NotasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/notas" }.should route_to(:controller => "notas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/notas/new" }.should route_to(:controller => "notas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/notas/1" }.should route_to(:controller => "notas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/notas/1/edit" }.should route_to(:controller => "notas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/notas" }.should route_to(:controller => "notas", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/notas/1" }.should route_to(:controller => "notas", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/notas/1" }.should route_to(:controller => "notas", :action => "destroy", :id => "1")
    end

  end
end
