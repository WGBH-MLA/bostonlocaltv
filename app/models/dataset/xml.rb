class Dataset::Xml < Dataset::Base
  def xml
    @xml ||= Nokogiri::XML(content)
  end

  def records
    xml.xpath("//xmlns:ROW", xmlns)
  end

  def xmlns
    xml.namespaces
  end

  def process! opts = {}
    run_callbacks(:process) do
      records.each do |row|
        solr_doc = {}

        run_callbacks(:process_record) do

          process_record(row, solr_doc)

          solr_doc[:id] ||= row.xpath(record_unique_id, xmlns).to_s
          solr_doc[:title_sort] = solr_doc[:title_s].first unless solr_doc[:title_s].blank?
          solr_doc[:year_i] = solr_doc[:date_s].first[/19\d\d/] unless solr_doc[:date_s].blank?
          solr_doc[:xml_display_s] = row.to_s

        end

        Blacklight.solr.add solr_doc, :add_attributes => { :commitWithin => 10000 }
      end
    end
  end

  protected
  def records_xpath
    "//xmlns:ROW"
  end

  def record_unique_id
    "@RECORDID"
  end

  def process_record(row, solr_doc = {})
    solr_doc ||= {}
    fields = []
    row.xpath("*").select { |x| !x.text.blank? }.each do |node|
      fields << ["#{node.name.parameterize}_s", node.text]
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
