namespace :data do
  desc "Load BPL data"
  task :bpl => :environment do
    require 'progressbar'
    file = ENV['file']
    raise unless file

    f = File.read(file)
    f.gsub!(/(<\/?[A-Z_]+):/) { $1 }

    xml = Nokogiri::XML(f)

    pbar = ProgressBar.new "indexing", xml.xpath("//xmlns:ROW", xml.namespaces).length

    xml.xpath("//xmlns:ROW", xml.namespaces).each do |row|
      pbar.inc
      solr_doc = {}

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
      
      solr_doc.merge!({
        :id => row.xpath("@RECORDID").to_s
      })
      Blacklight.solr.add solr_doc, :add_attributes => { :commitWithin => 10000 }
    print solr_doc.inspect
    print "\n"

    end

    pbar.finish
  end
end
