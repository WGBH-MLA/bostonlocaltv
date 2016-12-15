require 'open-uri'
require 'nokogiri'

class Dataset::Xml < Dataset::Base

  def xml
    @xml ||= Nokogiri::XML(
      File.read(file).gsub(/(<\/?[A-Za-z0-9_]+):/) { $1 }
    )
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

  def self.parse_date date
    if /^.*(?<year>\d{4}).*$/ =~ date
      year
    end
  end

  def self.date_fields(node)
    fields = []
    if (node.values()[0] == "created")
      if node.text.eql? ""
        fields << ["year_i", "1970"]
      else
        y = parse_date node.text
        fields << ["year_i", y]
        fields << ["date_created_s", node.text]

        # Creates a field for secondary sorting by date_created.
        # Returns nil for poorly formatted dates.
        fields << ["date_created_dt", convert_date_for_solr(node.text)]
      end
    end
    if (node.values()[0] == "broadcast") # TODO: only CCTV?
      fields << ['broadcast_date_s', node.text]
    end

    fields
  end

  def self.title_fields(node)
    fields = []
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
    elsif node.values()[0] == "Series"
      fields << ["collection_s", node.text]
    else
      fields << ["#{node.name.parameterize}_s", node.text]
    end
    fields
  end

  def self.convert_date_for_solr(string)
    if /^((0[1-9]|1[012])|[1-9])\/\d{4}$/.match(string)
      time = safe_month_year_parse(string)
    elsif /^(([1-9]|0[1-9])|1[012])\/([1-9]|0[1-9]|[12][0-9]|3[01])\/\d{4}$/.match(string)
      time = safe_full_date_parse(string)
    else
      time = nil
    end

    solr_date = if time.present?
      Time.parse(time.to_s).utc.iso8601
    else
      nil
    end
  end

  def self.safe_month_year_parse(string)
    DateTime.strptime(string, '%m/%Y')
  rescue ArgumentError
    nil
  end

  def self.safe_full_date_parse(string)
    DateTime.strptime(string, '%m/%d/%Y')
  rescue ArgumentError
    nil
  end
end
