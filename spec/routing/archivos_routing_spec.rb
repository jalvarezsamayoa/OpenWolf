require "spec_helper"

describe ArchivosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/archivos" }.should route_to(:controller => "archivos", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/archivos/new" }.should route_to(:controller => "archivos", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/archivos/1" }.should route_to(:controller => "archivos", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/archivos/1/edit" }.should route_to(:controller => "archivos", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/archivos" }.should route_to(:controller => "archivos", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/archivos/1" }.should route_to(:controller => "archivos", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/archivos/1" }.should route_to(:controller => "archivos", :action => "destroy", :id => "1")
    end

  end
end
