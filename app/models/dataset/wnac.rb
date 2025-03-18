class Dataset::wnac < Dataset::Xml

    protected
  
    def process_record row, solr_doc = nil
      solr_doc ||= {}
      fields = []
      title = false
      date_created = false
  
      row.xpath("*").select { |x| !x.text.blank? }.each do |node|
        case node.name
        when "pbcoreAssetDate"	
          fields += Dataset::Xml.date_fields(node)
  
        when "pbcoreIdentifier"
          # the IDs for wnac records are in <pbcoreIdentifier source="Accession #">
          if !node.values()[0].scan("Accession").empty?
            wnac_id = node.text
            if wnac_id.include? '.'
              wnac_id.gsub!('.', '_')
            end
            fields << ["id", wnac_id]
          elsif node.values()[0] == "Digital_Filename"
            fields << ["video_s", "wnac/videos/#{node.text.strip}.mp4"]
            fields << ["image_s", "wnac/images/#{node.text.strip}_thumbnail.jpg"]
            # Files were renamed to match id before uploading to S3.
            fields << ["video_b", true]
            fields << ["image_b", true]
          else
            fields << ["#{node.name.parameterize}_s", node.text]
          end
  
        when "pbcoreTitle"
          fields += Dataset::Xml.title_fields(node)
  
        when "pbcoreSubject"
          if node.values()[0] == "category"
            fields << ["subject_s", node.text]
            fields << ["subject_facet_s", node.text]
          end
  
          if node.values()[0] == "entity"
            fields << ["subject_s", node.text]
            fields << ["subject_facet_s", node.text]
          end
  
          if node.attributes['subjectType'].try(:value) == "entity"
            fields << ['entity_s', node.text]
          end
  
        when "pbcoreRelation"
          node.children().each do |child|
            case child.name
            when "pbcoreRelationIdentifier"
              source = child.text.downcase
              if source.eql? "wnac collection"
                fields << ["collection_s", child.text]
              end
            end
          end
  
        when "pbcoreDescription"
          fields << ["description_s", node.text]
  
        when "pbcoreContributor"
          if (node.children() == nil)
            fields << ["contributor_name_role_s", node.text]
          end
  
          node.children().each do |child|
            case child.name
            when "contributor"
              people = child.text
  
            when "contributorRole"
              contributor_name_role = "#{people} (#{child.text})"
              fields << ["contributor_name_role_s", contributor_name_role]
            end
          end
  
        when "pbcoreInstantiation"
          node.children().each do |child|
            case child.name
            when "instantiationDimensions"
              fields << ["footage_length_s", child.text]
            end
          end
  
        else
          fields << ["#{node.name.parameterize}_s", node.text]
        end
  
      end
  
      get_wnac_solr_doc fields, solr_doc
  
    end
  
  
    def get_wnac_solr_doc (fields, solr_doc)
      format = wnac_title = false
      
      fields.each do |key, value|
        format ||= key == 'format'
        description ||= key == 'description_s'
        wnac_title ||= key == 'title_s'
  
        next if value.blank?
   
        key.gsub!('__', '_')
        solr_doc[key.to_sym] ||= []
        solr_doc[key.to_sym] << (value.respond_to?(:strip) ? value.strip : value)
      end
  
      solr_doc [:format] = "Film:16mm" unless format
      solr_doc [:title_s] = "wnac" unless wnac_title
  
      solr_doc
    end
  
  end