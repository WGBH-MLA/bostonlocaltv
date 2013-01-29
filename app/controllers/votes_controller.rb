class VotesController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper

  copy_blacklight_config_from(CatalogController)

  helper CatalogHelper

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all

    @response, @documents = get_solr_response_for_field_values("id",session[:folder_document_ids] || [])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end

  # POST /votes
  # POST /votes.json
  def create
      the_time = "the_time" + "_" + params[:vote][:item_id]
       cookies[:"#{the_time}"] = Time.now.to_s
       @vote = Vote.new
       @vote.item_id = params[:vote][:item_id]
       @vote.user_id = cookies[:"#{the_time}"]
       @vote.title = params[:vote][:title]
       item = params[:vote][:item_id]
       uid = params[:vote][:user_id]
 
      begin
#        @item = Item.find (item)
		@item = Item.find_by_item_id(item)

        # FIXME: counter_cache on items table crapped out. Mabye due to trying to use item_id as id field.
        # This hack is bullshit but we need the votes working pronto.
        @votes = Vote.find_by_sql("select count(item_id) as votes_count from votes where item_id='#{item}'")
        @item.votes_count = @votes[0].votes_count + 1 
		count = @item.votes_count
    rescue
       @item = Item.new
       @item.item_id = item
       @item.votes_count=1
       @item.save
    end

    @extant = Vote.find(:all, :conditions => ["item_id = ? AND user_id = ?", item, uid])

    if (@extant.blank?)
       respond_to do |format|
          if @vote.save
            format.js
            format.json { render json: @vote, status: :created, location: @vote }
          else
            format.html { render action: "new" }
            format.json { render json: @vote.errors, status: :unprocessable_entity }
          end
        end
    else
     render partial: "dvotes", locals: {:vcount => count, :item_id => item}
    end

  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :ok }
    end
  end
end
