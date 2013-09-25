require 'spec_helper'

describe ShoppingCartsController do

  def valid_attributes
    #create :shopping_cart
  end
  
  before :each do
    
  end

  describe "POST create" do
    describe "with valid params" do
      pending "creates a new ShoppingCart" do
        expect {
          post :create, :shopping_cart => valid_attributes
        }.to change(ShoppingCart, :count).by(1)
      end

      pending "assigns a newly created shopping_cart as @shopping_cart" do
        post :create, :shopping_cart => valid_attributes
        assigns(:shopping_cart).should be_a(ShoppingCart)
        assigns(:shopping_cart).should be_persisted
      end

      pending "redirects to the created shopping_cart" do
        post :create, :shopping_cart => valid_attributes
        response.should redirect_to(ShoppingCart.last)
      end
    end

    describe "with invalid params" do
      pending "assigns a newly created but unsaved shopping_cart as @shopping_cart" do
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        post :create, :shopping_cart => {}
        assigns(:shopping_cart).should be_a_new(ShoppingCart)
      end

      pending "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        post :create, :shopping_cart => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      pending "updates the requested shopping_cart" do
        shopping_cart = ShoppingCart.create! valid_attributes
        # Assuming there are no other shopping_carts in the database, this
        # specifies that the ShoppingCart created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ShoppingCart.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => shopping_cart.id, :shopping_cart => {'these' => 'params'}
      end

      pending "assigns the requested shopping_cart as @shopping_cart" do
        shopping_cart = ShoppingCart.create! valid_attributes
        put :update, :id => shopping_cart.id, :shopping_cart => valid_attributes
        assigns(:shopping_cart).should eq(shopping_cart)
      end

      pending "redirects to the shopping_cart" do
        shopping_cart = ShoppingCart.create! valid_attributes
        put :update, :id => shopping_cart.id, :shopping_cart => valid_attributes
        response.should redirect_to(shopping_cart)
      end
    end

    describe "with invalid params" do
      pending "assigns the shopping_cart as @shopping_cart" do
        shopping_cart = ShoppingCart.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        put :update, :id => shopping_cart.id.to_s, :shopping_cart => {}
        assigns(:shopping_cart).should eq(shopping_cart)
      end

      pending "re-renders the 'edit' template" do
        shopping_cart = ShoppingCart.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        put :update, :id => shopping_cart.id.to_s, :shopping_cart => {}
        response.should render_template("edit")
      end
    end
  end

end
