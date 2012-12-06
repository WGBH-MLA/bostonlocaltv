module VisitsHelper
    def save_visit (doc_title, doc_id)
        begin
         @v = Visit.find_by_item_id (doc_id)
         @v.update_attribute(:visits, @v.visits+1) 
        rescue
        visit = Visit.new
        visit.title = doc_title
        visit.item_id = doc_id
        visit.visits = 1
        visit.save
	end
   end

   def get_top_visits?()
        begin
           @extant = Vote.find_by_sql("select item_id, title, visits from visits order by visits desc limit 5;")
        rescue
           nil
        end
   end

end
