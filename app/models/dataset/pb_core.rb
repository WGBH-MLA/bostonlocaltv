class Dataset::Pb_core < Dataset::Xml
  def content
    super.gsub(/(<\/?[A-Za-z0-9_]+):/) { $1 } 
  end
  
  protected

  def process_record row, solr_doc = nil
    solr_doc ||= {}
    fields = []

    row.xpath("*").select { |x| !x.text.blank? }.each do |node|
      case node.name
	when "pbcoreAssetDate"	
		v = "created"
                if (node.values()[0] == v)
		   if node.text.eql? "" 
		     created_year = "1970"
		     fields << ["year_i", created_year]
		   else
		     y = parse_date node.text
		     fields << ["year_i", y]
	           end 
		end
        when "pbcoreIdentifier"
	     a_v = "UID"
             b_v = "Accession_NUMBER"
             c_v = "id_program"

	     if node.values()[0] == a_v || node.values()[0] == b_v || node.values()[0] == c_v
		fields << ["id", node.text]
	     else
		fields << ["#{node.name.parameterize}_s", node.text]
             end

        when "pbcoreTitle"
              if node.values()[0] == nil || node.values()[0] == "Description" || node.values()[0] == "Program"
		 fields << ["title_s", node.text]
              elsif node.values()[0] == "Series"
		 fields << ["collection_s", node.text]
	      else
		 fields << ["#{node.name.parameterize}_s", node.text]
	      end

	when "pbcoreRelation"
		node.children().each do |child|
		case child.name
		 when "pbcoreRelationIdentifier"
			   source = child.text.downcase
			if source.eql? "whdh" or source.eql? "wcvb" or source.eql? "cctv"
			     fields << ["collection_s", child.text] 
		       end
		   end
                 end	

	when "pbcoreDescription"
		fields << ["description_s", node.text]
 
        when "pbcoreSubject"
		if node.values()[0] == "category"
		   fields << ["subject_s", node.text]
                end

	when "pbcoreInstantiation"
		node.children().each do |child|
                 case child.name
		    when "instantiationPhysical"
			fields << ["format", child.text]
	             end
		 end	  
        else 
          fields << ["#{node.name.parameterize}_s", node.text]
      end
    end

    fields.each do |key, value|
      next if value.blank?
      key.gsub!('__', '_')
      solr_doc[key.to_sym] ||= []
      solr_doc[key.to_sym] <<  value.strip
    end

    solr_doc
  end

def parse_date date
    if /^.*(?<year>\d{4}).*$/ =~ date
       year
    end
end

end
