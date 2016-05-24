class Dataset::Wgbh < Dataset::Xml

  protected

  def process_record row, solr_doc = nil
    solr_doc ||= {}
    fields = []
    title = false
    date_created = false
    people = " "
    physical_format = ""

    row.xpath("*").select { |x| !x.text.blank? }.each do |node|
      case node.name
      when "pbcoreAssetDate"	
        fields += Dataset::Xml.date_fields(node)
      
      when "pbcoreIdentifier"
        if node.values()[0] == "UID"
          fields << ["id", node.text]
        elsif node.values()[0] == "Digital_Filename"
          # Files were renamed to match id before uploading to S3.
          fields << ["video_b", true]
          fields << ["image_b", true]
        else
          fields << ["#{node.name.parameterize}_s", node.text]
        end

      when "pbcoreTitle"
        fields += Dataset::Xml.title_fields(node)

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

        if node.attributes['subjectType'].try(:value) == "entity"
          fields << ['entity_s', node.text]
        end

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
            if (physical_format.empty?)
              physical_format = child.text
            else
              physical_format = physical_format + ", " + child.text
            end

          when "instantiationDuration"
            fields << ["audio_duration_s", "  "]
          end
        end

      when "pbcoreAssetType"
        fields << ["intended_purpose_s", node.text]	
      else
        fields << ["#{node.name.parameterize}_s", node.text]
      end
    end

    get_wgbh_solr_doc fields, solr_doc, physical_format
  end

  def get_wgbh_solr_doc (fields, solr_doc, physical_format)
    format = color = wgbh_title = false
    
    fields.each do |key, value|
      format ||= key == 'format'
      color ||= key == 'format_color_s'
      wgbh_title ||= key == 'title_s'

      next if value.blank?
  
      key.gsub!('__', '_')
      solr_doc[key.to_sym] ||= []
      solr_doc[key.to_sym] << (value.respond_to?(:strip) ? value.strip : value)
    end
 
    solr_doc ['format'] = physical_format unless format
    solr_doc ['format_color_s'] = "Color" unless color
    solr_doc ['title_s'] = "Ten O'Clock News" unless wgbh_title

    solr_doc
  end

end
