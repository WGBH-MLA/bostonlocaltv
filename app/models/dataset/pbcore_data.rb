class Dataset::PbcoreData < Dataset::Xml
  def content
    super.gsub(/(<\/?[A-Za-z0-9_]+):/) { $1 } 
  end

  protected
  def process_record row, solr_doc = nil
    solr_doc ||= {}
    fields = []
    row.xpath("*").select { |x| !x.text.blank? }.each do |node|
      foo = ["#{node.name.parameterize}_s", node.text]
      fields << foo
      #fields << ["#{node.name.parameterize}_s", node.text]
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
