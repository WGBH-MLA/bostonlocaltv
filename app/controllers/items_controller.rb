class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    @vote = Vote.new(params[:vote])
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @vote = Vote.new(params[:vote])
    # @item = Item.find(params[:id])
    @item = Item.find_by_item_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    # @item = Item.find(params[:id])
    @item = Item.find_by_item_id(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item_id])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
#     @item = Item.find(params[:id])
	@item = Item.find_by_item_id(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
#     @item = Item.find(params[:item_id])
	@item = Item.find_by_item_id(params[:item_id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end
  
  def find_by_item_id(doc_id)
	  @item = Item.find_by_sql("select * from items where item_id=\"#{doc_id}\"").first
  end
end