class ShoppingCartsController < ApplicationController
  
  before_filter :authenticate_user!
  
  # GET /shopping_carts/1
  # GET /shopping_carts/1.json
  # def show
#     @shopping_cart = ShoppingCart.find(params[:id])
#     if @shopping_cart.user_id == current_user.id
#       respond_to do |format|
#         format.html # show.html.erb
#         format.json { render json: @shopping_cart }
#       end
#     else
#       redirect_to '/'
#     end
#   end

  # POST /shopping_carts
  # POST /shopping_carts.json
  def create
    @shopping_cart = ShoppingCart.new(params[:shopping_cart])
    @shopping_cart.user_id = current_user.id

    respond_to do |format|
      if @shopping_cart.save
        format.html { redirect_to @shopping_cart, notice: 'Shopping cart was successfully created.' }
        format.json { render json: @shopping_cart, status: :created, location: @shopping_cart }
      else
        format.html { render action: "new" }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shopping_carts/1
  # PUT /shopping_carts/1.json
  def update
    @shopping_cart = ShoppingCart.user_open_cart(current_user).last
    respond_to do |format|
      if @shopping_cart.update_attributes(params[:shopping_cart])
        format.html { redirect_to @shopping_cart, notice: 'Shopping cart was successfully updated.' }
        format.json { render json: @shopping_cart }
      else
        format.html { render action: "edit" }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_carts/1
  # DELETE /shopping_carts/1.json
  def destroy
    @shopping_cart = ShoppingCart.find(params[:id])
    @shopping_cart.destroy

    respond_to do |format|
      format.html { redirect_to shopping_carts_url }
      format.json { head :ok }
    end
  end
  
  def empty
    @cart = ShoppingCart.find(params[:shopping_cart_id])
    if params[:form_submit] == 'true'
      if @cart.shopping_cart_items.delete_all
        render json: @cart
      else
        render json: @cart.errors, status: :unprocessable_entity
      end
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end
  
end
