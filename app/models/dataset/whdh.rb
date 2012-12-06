class Dataset::Whdh < Dataset::Xml
  def content
    super.gsub(/(<\/?[A-Za-z0-9_]+):/) { $1 } 
  end
  
  protected

  def process_record row, solr_doc = nil
    solr_doc ||= {}
    fields = []
    title = false
    date_created = false
    people = " "
    date_estimated = false

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
	             fields << ["date_created_s", node.text]
		     fields << ["date_estimated_s", node.text]
	           end 
		end
        when "pbcoreIdentifier"
	     a_v = "UID"

	     if node.values()[0] == a_v 
		fields << ["id", node.text]
	     else
		fields << ["#{node.name.parameterize}_s", node.text]
             end

        when "pbcoreTitle"
              if node.values()[0] == nil || node.values()[0] == "Description" || node.values()[0] == "Program"
                 if node.text[0] == "\""
                    title = node.text.to_s.gsub(/\"(.*)\"/, '\1')
                    fields <<["title_s", title]
                 elsif node.values()[0] == "\'"
 		    title = node.text.to_s.gsub(/\'(.*)\'/, '\1')
                    fields << ["title_s", title]  
                 else
		    fields << ["title_s", node.text]
                 end
	      else
		 fields << ["#{node.name.parameterize}_s", node.text]
	      end

	when "pbcoreRelation"
                 node.children().each do |child|
                case child.name
                 when "pbcoreRelationIdentifier"
                           source = child.text.downcase
                        if source.eql? "whdh" 
                             fields << ["collection_s", child.text]
                        else
                             fields << ["cross_reference_s", child.text]
                        end
                   end
                 end   

	when "pbcoreDescription"
		fields << ["description_s", node.text]
 
        when "pbcoreSubject"
		if node.values()[0] == "category"
		   fields << ["subject_s", node.text]
		   fields << ["subject_facet_s", node.text]
                end
               
                if node.values()[0] == nil
                   fields << ["subject_s", node.text]
		   fields << ["subject_facet_s", node.text]
                end

         when "pbcoreContributor"
                if (node.children() == nil)
                    fields << ["people_s", node.text]
                    fields << ["contributor_name_role_s", node.text]
                end
 
                node.children().each do |child|
                case child.name
                    when "contributor"
                       fields << ["people_s", child.text]
                       people = child.text
                    when "contributorRole"
		       contributor_name_role = people + ", " + child.text 
   		       fields << ["contributor_name_role_s", contributor_name_role]
                    end
                end

         when "pbcoreCoverage"
               node.children().each do |child|
               case child.name
                   when "coverage"
                       fields << ["location_s", child.text]
		       fields << ["location_facet_s", child.text]
                   end
               end
        
	 when "pbcoreInstantiation"
		node.children().each do |child|
                 case child.name
		    when "instantiationPhysical"
			fields << ["format", child.text]
                    when "instantiationTracks"
                        fields << ["audio_format_s", child.text]
                    when "instantiationMediaType"
                        fields << ["audio_type_s", child.text]
		    when "instantiationDimensions"
			fields << ["footage_length_s", child.text]
		    when "instantiationColors"
		        fields << ["format_color_s", child.text]
		    when "instantiationDuration"
			fields << ["audio_duration_s", child.text]
		    end
		 end	  

 	when "pbcoreAssetType"
                 fields << ["intended_purpose_s", node.text]	

	when "pbcoreAnnotation"
		date_estimated = true
	
        else 
          fields << ["#{node.name.parameterize}_s", node.text]
      end

     end

        get_whdh_solr_doc fields, solr_doc, date_estimated
     
       
    end


def get_whdh_solr_doc (fields, solr_doc, date_estimated)
   date_created = false
   audio_format = false
   audio_type = false
    contributor = false
    cross_reference = false
    dimensions = false
    color = false
    duration = false
    purpose = false
    location = false
    subject = false
    description = false

    fields.each do |key, value|
     if key == 'date_created_s'
        date_created = true
     end
     if key == 'audio_format_s'
         audio_format = true 	 
     end
     if key == 'audio_type_s'
	 audio_type = true
     end
     if key == 'contributor_name_role_s'
	 contributor = true
     end
     if key == 'cross_reference_s'  
	 cross_reference = true
     end
     if key == 'footage_length_s'
	 dimensions = true
     end
     if key == 'format_color_s'
	 color = true
     end
     if key == 'audio_duration_s'	
         duration = true
     end
     if key == 'intended_purpose_s'
	 purpose = true
     end
     if key == 'location_s'
	 location = true
     end
     if key == 'subject_s'
         subject = true
     end
     if key == 'description_s'
         description = true
     end

      next if value.blank?
      key.gsub!('__', '_')
      solr_doc[key.to_sym] ||= []
      solr_doc[key.to_sym] <<  value.strip
   end

     if date_created == false
        solr_doc ['date_created_s'] = " "
     end
     if audio_format == false 
      solr_doc ['audio_format_s'] = " "
     end
     if audio_type == false 
      solr_doc ['audio_type_s'] = " "
     end
     if contributor == false 
       solr_doc ['contributor_name_role_s'] = " "
     end
     if  cross_reference == false 
	solr_doc ['cross_reference_s'] = " " 
     end
     if dimensions == false 
	solr_doc ['footage_length_s'] = " " 
     end
     if color == false 
	solr_doc ['format_color_s'] = " "
     end
     if duration == false 
	solr_doc ['audio_duration_s'] = " "
     end
     if purpose == false 
	solr_doc ['intended_purpose_s'] = " "
     end
     if location == false 
	solr_doc ['location_s'] = " "
     end
     if subject == false 
	solr_doc ['subject_s'] = " "
     end
     if description == false
	solr_doc ['description_s']= " "
     end

      if date_estimated == true
	 solr_doc[:date_created_s] = ""
      else
	 solr_doc[:date_estimated_s] = ""
      end

     solr_doc

  end 

def parse_date date
    if /^.*(?<year>\d{4}).*$/ =~ date
       year
    end
end

end
