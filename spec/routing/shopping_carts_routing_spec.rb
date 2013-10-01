require "spec_helper"

describe ShoppingCartsController do
  describe "routing" do

    pending "routes to your current cart" do
      get('/cart').should route_to("users#cart")
    end
    
    pending 'routes to your orders' do
      get('/orders').should route_to('users#orders')
    end

  end
end
