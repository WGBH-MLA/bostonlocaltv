module ItemsHelper
   def get_vote_count?(doc_id)
    begin
      @item = Item.find (doc_id)
      @item.votes_count
    rescue
    end
  end

  def get_vote?(doc_id, user_id)
        begin
          item = doc_id
          uid = user_id

          @extant = Vote.find(:last, :conditions => ["item_id = ? AND user_id = ?", item, uid])
          if (@extant.item_id.blank?)
             0
          else
             1
          end
        rescue
          0
        end
     end
end
