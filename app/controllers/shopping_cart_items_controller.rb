class ShoppingCartItemsController < ApplicationController
  # GET /shopping_cart_items
  # GET /shopping_cart_items.json
  def index
    @shopping_cart_items = ShoppingCartItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shopping_cart_items }
    end
  end

  # GET /shopping_cart_items/1
  # GET /shopping_cart_items/1.json
  def show
    @shopping_cart_item = ShoppingCartItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @shopping_cart_item }
    end
  end

  # GET /shopping_cart_items/new
  # GET /shopping_cart_items/new.json
  def new
    @shopping_cart_item = ShoppingCartItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shopping_cart_item }
    end
  end

  # GET /shopping_cart_items/1/edit
  def edit
    @shopping_cart_item = ShoppingCartItem.find(params[:id])
  end

  # POST /shopping_cart_items
  # POST /shopping_cart_items.json
  def create
    @shopping_cart_item = ShoppingCartItem.new(params[:shopping_cart_item])

    respond_to do |format|
      if @shopping_cart_item.save
        format.html { redirect_to @shopping_cart_item, notice: 'Shopping cart item was successfully created.' }
        format.json { render json: @shopping_cart_item, status: :created, location: @shopping_cart_item }
      else
        format.html { render action: "new" }
        format.json { render json: @shopping_cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /shopping_cart_items/1
  # PUT /shopping_cart_items/1.json
  def update
    @shopping_cart_item = ShoppingCartItem.find(params[:id])

    respond_to do |format|
      if @shopping_cart_item.update_attributes(params[:shopping_cart_item])
        format.html { redirect_to @shopping_cart_item, notice: 'Shopping cart item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shopping_cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_cart_items/1
  # DELETE /shopping_cart_items/1.json
  def destroy
    @shopping_cart_item = ShoppingCartItem.find(params[:id])
    @shopping_cart_item.destroy

    respond_to do |format|
      format.html { redirect_to shopping_cart_items_url }
      format.json { head :ok }
    end
  end
end
