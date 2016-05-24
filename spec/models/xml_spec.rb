require 'active_support/core_ext/string'
require 'active_model'

require_relative '../../app/models/dataset'
require_relative '../../app/models/dataset/xml'

describe 'Xml (pbcore to solr conversion)' do
  
  Dir[__dir__+'/../fixtures/xml/*.pbcore.xml'].each do |pbcore_path|
    station = pbcore_path.gsub(/.*\//, '').gsub(/\..*/, '')
    solr_path = "#{__dir__}/../fixtures/xml/#{station}.solr.json"
    it "translates #{File.basename(pbcore_path)} to #{File.basename(solr_path)}" do
      class_path = "#{__dir__}/../../app/models/dataset/#{station}"
      require class_path
      "Dataset::#{station.titlecase}".constantize.new(pbcore_path)
    end
  end
end