class UsersController < ApplicationController

  before_filter :authenticate_user!

  def show
    @user = current_user
  end
  
  def cart
    @cart = ShoppingCart.user_open_cart(current_user).last
  end
  
  def orders
    @carts_open = ShoppingCart.has_items(current_user).open
    @carts_pending = ShoppingCart.has_items(current_user).pending
    @carts_closed = ShoppingCart.has_items(current_user).closed
  end
  
  def submit_cart
    @cart = ShoppingCart.user_open_cart(current_user).last
    @cart.status = 'submitted'
    if @cart.save
      render json: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end
  
end