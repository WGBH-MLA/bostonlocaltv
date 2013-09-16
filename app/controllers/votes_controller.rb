class VotesController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper

  copy_blacklight_config_from(CatalogController)

  helper CatalogHelper

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
      # @item = Item.find (item)
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
end
