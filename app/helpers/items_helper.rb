module ItemsHelper
  def get_vote_count (doc_id)                                    
    begin
      @item = Item.find (doc_id)
      @item.votes_count
    rescue
      @item.votes_count = ""
    end
  end  
end
