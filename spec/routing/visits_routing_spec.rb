require "spec_helper"

describe VisitsController do
  describe "routing" do

    it "routes to #index" do
      get("/visits").should route_to("visits#index")
    end

    it "routes to #new" do
      get("/visits/new").should route_to("visits#new")
    end

    it "routes to #show" do
      get("/visits/1").should route_to("visits#show", :id => "1")
    end

    it "routes to #edit" do
      get("/visits/1/edit").should route_to("visits#edit", :id => "1")
    end

    it "routes to #create" do
      post("/visits").should route_to("visits#create")
    end

    it "routes to #update" do
      put("/visits/1").should route_to("visits#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/visits/1").should route_to("visits#destroy", :id => "1")
    end

  end
end
