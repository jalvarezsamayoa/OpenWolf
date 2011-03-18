require "spec_helper"

describe FeriadosController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/feriados" }.should route_to(:controller => "feriados", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/feriados/new" }.should route_to(:controller => "feriados", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/feriados/1" }.should route_to(:controller => "feriados", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/feriados/1/edit" }.should route_to(:controller => "feriados", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/feriados" }.should route_to(:controller => "feriados", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/feriados/1" }.should route_to(:controller => "feriados", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/feriados/1" }.should route_to(:controller => "feriados", :action => "destroy", :id => "1")
    end

  end
end
