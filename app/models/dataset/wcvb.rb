class Dataset::Wcvb < Dataset::Xml
  def content
    super.gsub(/(<\/?[A-Za-z0-9_]+):/) { $1 }
  end

  protected

  def process_record row, solr_doc = nil
    solr_doc ||= {}
    fields = []
    title = false
    date_created = false

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
          end
        end

      when "pbcoreIdentifier"
        # the IDs for WCVB records are in <pbcoreIdentifier source="Accession #">
        if !node.values()[0].scan("Accession").empty?
          wcvb_id = node.text
          if wcvb_id.include? '.'
            wcvb_id.sub!('.', '_')
          end
          fields << ["id", wcvb_id]
        elsif node.values()[0] == "Digital_Filename"
          fields << ["video_s", "wcvb/videos/#{node.text.strip}.mp4"]
          fields << ["image_s", "wcvb/images/#{node.text.strip}_thumbnail.jpg"]
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
            if source.eql? "wcvb collection"
              fields << ["collection_s", child.text]
            end
          end
        end

      when "pbcoreDescription"
        fields << ["description_s", node.text]

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

    get_wcvb_solr_doc fields, solr_doc

  end


  def get_wcvb_solr_doc (fields, solr_doc)
    date_created = false
    dimensions = false
    format = false
    description = false
    wcvb_title = false

    fields.each do |key, value|
      if key == 'date_created_s'
        date_created = true
      end
      if key == 'footage_length_s'
        dimensions = true
      end
 
      if key == 'format'
        format = true
      end
 
      if key == 'description_s'
        description = true
      end
 
      if key == 'title_s'
        wcvb_title = true
      end

      next if value.blank?
 
      key.gsub!('__', '_')
      solr_doc[key.to_sym] ||= []
      solr_doc[key.to_sym] <<  value.strip
    end

    if format == false
	   solr_doc [:format] = "Film:16mm"
    end

    if wcvb_title == false
	    solr_doc [:title_s] = "WCVB"
    end

    solr_doc
  end

  def parse_date date
    if /^.*(?<year>\d{4}).*$/ =~ date
      year
    end
  end

end
