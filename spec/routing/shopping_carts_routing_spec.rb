require "spec_helper"

describe ShoppingCartsController do
  describe "routing" do

    pending "routes to #index" do
      get("/shopping_carts").should route_to("shopping_carts#index")
    end

    pending "routes to #new" do
      get("/shopping_carts/new").should route_to("shopping_carts#new")
    end

    pending "routes to #show" do
      get("/shopping_carts/1").should route_to("shopping_carts#show", :id => "1")
    end

    pending "routes to #edit" do
      get("/shopping_carts/1/edit").should route_to("shopping_carts#edit", :id => "1")
    end

    pending "routes to #create" do
      post("/shopping_carts").should route_to("shopping_carts#create")
    end

    pending "routes to #update" do
      put("/shopping_carts/1").should route_to("shopping_carts#update", :id => "1")
    end

    pending "routes to #destroy" do
      delete("/shopping_carts/1").should route_to("shopping_carts#destroy", :id => "1")
    end

  end
end
