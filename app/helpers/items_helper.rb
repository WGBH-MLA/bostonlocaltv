module ItemsHelper
   def get_vote_count?(doc_id)
    begin
#       @item = Item.find (doc_id)
#		@item = Item.find_by_item_id(doc_id)
      
      # FIXME: counter_cache 'votes_count' on the Item model is not working. Maybe something to do with not joining on item_id field. Change this back once it's working again. 
      @extant = Vote.find_by_sql("select item_id, count(item_id) as votes_count from votes where item_id = '#{doc_id}' group by item_id limit 1;", doc_id)
      @extant[0].votes_count
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
           #@extant = Vote.find_by_sql("select item_id, votes_count from items order by votes_count desc limit 5;")
           # FIXME: counter_cache 'votes_count' on the Item model is not working. Maybe something to do with not joining on item_id field. Change this back once it's working again. 
           @extant = Vote.find_by_sql("select item_id, count(item_id) as votes_count from votes group by item_id order by votes_count desc limit 5;")
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
