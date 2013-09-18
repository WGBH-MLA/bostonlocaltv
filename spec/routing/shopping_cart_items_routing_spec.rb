require "spec_helper"

describe ShoppingCartItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/shopping_cart_items").should route_to("shopping_cart_items#index")
    end

    it "routes to #new" do
      get("/shopping_cart_items/new").should route_to("shopping_cart_items#new")
    end

    it "routes to #show" do
      get("/shopping_cart_items/1").should route_to("shopping_cart_items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shopping_cart_items/1/edit").should route_to("shopping_cart_items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/shopping_cart_items").should route_to("shopping_cart_items#create")
    end

    it "routes to #update" do
      put("/shopping_cart_items/1").should route_to("shopping_cart_items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/shopping_cart_items/1").should route_to("shopping_cart_items#destroy", :id => "1")
    end

  end
end
