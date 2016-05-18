class Dataset::Cctv < Dataset::Xml
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

    row.xpath("*").select { |x| !x.text.blank? }.each do |node|
      case node.name
      when "pbcoreAssetDate"
        v = "created"
        b = "broadcast"
        if (node.values()[0] == v)
          if node.text.eql? ""
            created_year = "1970"
            fields << ["year_i", created_year]
          else
            y = parse_date node.text
            fields << ["year_i", y]
            fields << ["date_created_s", node.text]
          end
        end

        if (node.values()[0] == b)
          fields << ['broadcast_date_s', node.text]
        end

      when "pbcoreIdentifier"
        if node.values()[0] == "id_program_prime"
          fields << ["id", node.text]
        elsif node.values()[0] == "Digital_Filename"
          # Files were renamed to match id before uploading to S3.
          fields << ["video_b", true]
          fields << ["image_b", true]
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
            if source.eql? "cctv"
              fields << ["collection_s", child.text]
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

        if node.values()[0] == "entity"
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
          when "instantiationColors"
            fields << ["format_color_s", child.text]
          when "instantiationDuration"
            fields << ["audio_duration_s", child.text]
          when "instantiationLanguage"
            fields << ["language_s", child.text]
          end
        end

      when "pbcoreAssetType"
        fields << ["intended_purpose_s", node.text]

      else
        fields << ["#{node.name.parameterize}_s", node.text]
      end
    end

    get_cctv_solr_doc fields, solr_doc

  end


  def get_cctv_solr_doc (fields, solr_doc)
    fields.each do |key, value|
      next if value.blank?
      key.gsub!('__', '_')
      solr_doc[key.to_sym] ||= []
      solr_doc[key.to_sym] << value.respond_to?(:strip) ? value.strip : value
    end

    solr_doc

  end

  def parse_date date
    if /^.*(?<year>\d{4}).*$/ =~ date
      year
    end
  end

end
