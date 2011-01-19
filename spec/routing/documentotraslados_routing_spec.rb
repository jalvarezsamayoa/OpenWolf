require "spec_helper"

describe DocumentotrasladosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/documentotraslados" }.should route_to(:controller => "documentotraslados", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/documentotraslados/new" }.should route_to(:controller => "documentotraslados", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/documentotraslados/1" }.should route_to(:controller => "documentotraslados", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/documentotraslados/1/edit" }.should route_to(:controller => "documentotraslados", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/documentotraslados" }.should route_to(:controller => "documentotraslados", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/documentotraslados/1" }.should route_to(:controller => "documentotraslados", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/documentotraslados/1" }.should route_to(:controller => "documentotraslados", :action => "destroy", :id => "1")
    end

  end
end
