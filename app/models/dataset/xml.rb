require 'open-uri'
require 'nokogiri'

class Dataset::Xml < Dataset::Base
  def xml
    @xml ||= Nokogiri::XML(content)
  end

  def records
    xml.xpath("//pbcore:pbcoreDescriptionDocument", "pbcore" => xml.namespaces["xmlns"])
  end

  def process! opts = {}
    log = Logger.new STDOUT
    run_callbacks(:process) do
      records.each do |row|
        solr_doc = {}
        run_callbacks(:process_record) do
          process_record(row, solr_doc)
          solr_doc[:title_sort] = solr_doc[:title_s].first unless solr_doc[:title_s].blank?
        end

        if solr_doc[:id].nil? or solr_doc[:id].empty?
          log.info "No ID found for record #"
          next
        end

        Blacklight.solr.add solr_doc, :add_attributes => { :commitWithin => 10000 }
      end
    end
  end

  protected

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
  
  def parse_date date
    if /^.*(?<year>\d{4}).*$/ =~ date
      year
    end
  end
end
