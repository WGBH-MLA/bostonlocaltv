class Dataset::Bpl < Dataset::Xml
  def content
    super.gsub(/(<\/?[A-Za-z0-9_]+):/) { $1 } 
  end

  protected
  def process_record row, solr_doc = nil
    solr_doc ||= {}
    fields = []
    row.xpath("*").select { |x| !x.text.blank? }.each do |node|
      case node.name
        when "CONTRIBUTOR"
          i = 0
          node.xpath("xmlns:DATA", "xml.namespaces").each do |contributor|
            i += 1
            fields <<  ['contributor_name_s', contributor.text]
            fields <<  ['contributor_name_role_s', "#{contributor.text}\0#{node.xpath("xmlns:CONTRIBUTOR_ROLE/xmlns:DATA[#{i}]", xml.namespaces).text}"]
          end
        when "SUBJECT_PERSONALITIES"  
          node.xpath("xmlns:DATA", "xml.namespaces").each do |subject|
            fields << ['subject_personalities_s', subject.text]
         print "passing the records"
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
end
