require 'spec_helper'

describe ShoppingCartsController do

  def valid_attributes
    #create :shopping_cart
  end
  
  before :each do
    @user = create(:user)
    sign_in @user
    @cart = attributes_for(:shopping_cart, :user_id => @user.id)
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ShoppingCart" do
        expect {
          post :create, :shopping_cart => @cart
        }.to change(ShoppingCart, :count).by(1)
      end

      it "assigns a newly created shopping_cart as @shopping_cart" do
        post :create, :shopping_cart => @cart
        assigns(:shopping_cart).should be_a(ShoppingCart)
        assigns(:shopping_cart).should be_persisted
      end

      it "redirects to the created shopping_cart" do
        post :create, :shopping_cart => @cart
        response.should redirect_to(ShoppingCart.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved shopping_cart as @shopping_cart" do
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        post :create, :shopping_cart => {}
        assigns(:shopping_cart).should be_a_new(ShoppingCart)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        post :create, :shopping_cart => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested shopping_cart" do
        shopping_cart = ShoppingCart.create! @cart
        # Assuming there are no other shopping_carts in the database, this
        # specifies that the ShoppingCart created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ShoppingCart.any_instance.should_receive(:update_attributes).with({'status' => 'pending'})
        put :update, :id => shopping_cart.id, :shopping_cart => {'status' => 'pending'}
      end

      it "assigns the requested shopping_cart as @shopping_cart" do
        shopping_cart = ShoppingCart.create! @cart
        put :update, :id => shopping_cart.id, :shopping_cart => @cart
        assigns(:shopping_cart).should eq(shopping_cart)
      end

      it "redirects to the shopping_cart" do
        shopping_cart = ShoppingCart.create! @cart
        put :update, :id => shopping_cart.id, :shopping_cart => @cart
        response.should redirect_to(shopping_cart)
      end
    end

    describe "with invalid params" do
      it "assigns the shopping_cart as @shopping_cart" do
        shopping_cart = ShoppingCart.create! @cart
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        put :update, :id => shopping_cart.id.to_s, :shopping_cart => {}
        assigns(:shopping_cart).should eq(shopping_cart)
      end

      it "re-renders the 'edit' template" do
        shopping_cart = ShoppingCart.create! @cart
        # Trigger the behavior that occurs when invalid params are submitted
        ShoppingCart.any_instance.stub(:save).and_return(false)
        put :update, :id => shopping_cart.id.to_s, :shopping_cart => {}
        response.should render_template("edit")
      end
    end
  end
  
  describe "GET empty" do
    describe "with valid params" do
      it "removes all items in the cart" do
        shopping_cart = ShoppingCart.create! @cart
        get :empty, :shopping_cart_id => shopping_cart.id.to_i, :submit_form => 'true'
        shopping_cart.shopping_cart_items.length.should eq(0)
      end
    end
    
    describe "without valid params" do
      it "returns error without 'form_submit' params"
    end
  end

end
