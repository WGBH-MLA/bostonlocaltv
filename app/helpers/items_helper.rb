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

   def get_top_votes?()
        begin
           @extant = Vote.find_by_sql("select item_id, votes_count from items order by votes_count desc limit 5;")
           @extant
          rescue
           nil
        end
   end

   def  get_doc_title (doc_id)
	begin
            @vote = Vote.find_by_item_id!(doc_id)
	    title = @vote.title
            title = title.gsub(/\"(.*)\"/, '\1')
	    title = title.gsub(/\[(.*)\]/, '\1')
            title
          rescue
            nil
        end
   end

   
end
