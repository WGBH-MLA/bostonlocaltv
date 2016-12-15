require 'active_support/core_ext/string'
require 'active_model'
require 'json'

require_relative '../../app/models/dataset'
require_relative '../../app/models/dataset/xml'

describe 'Xml (pbcore to solr conversion)' do

  let(:clean_mm_dd_yyyy) { '12/13/2016' }
  let(:clean_mm_yyyy) { '01/1976' }
  let(:clean_m_yyyy) { '1/1976' }
  let(:dirty_mm_dd_yyyy) { '13/36/1980' }
  let(:dirty_mm_yyyy) { '00/1974' }
  let(:dirty_m_yyyy) { '0/2004'}

  Dir[__dir__+'/../fixtures/xml/*.pbcore.xml'].each do |pbcore_path|
    station = pbcore_path.gsub(/.*\//, '').gsub(/\..*/, '')
    solr_path = "#{__dir__}/../fixtures/xml/#{station}.solr.json"
    it "translates #{File.basename(pbcore_path)} to #{File.basename(solr_path)}" do
      class_path = "#{__dir__}/../../app/models/dataset/#{station}"
      require class_path
      dataset = "Dataset::#{station.titlecase}".constantize.new(pbcore_path)
      records = dataset.records
      expect(records.count).to eq(1)
      solr_doc = {}
      dataset.send(:process_record, records.first, solr_doc)
      actual = JSON.pretty_generate(solr_doc)
      expected = File.read(solr_path)
      expect(actual).to eq(expected)
    end
  end

  describe '.convert_date_for_solr' do
    it 'returns valid DateTime for mm/dd/yyyy' do
      dt = Time.parse(DateTime.strptime(clean_mm_dd_yyyy, '%m/%d/%Y').to_s).utc.iso8601
      expect(Dataset::Xml.convert_date_for_solr(clean_mm_dd_yyyy)).to eq(dt)
    end

    it 'returns valid DateTime for mm/yyyy' do
      dt = Time.parse(DateTime.strptime(clean_mm_yyyy, '%m/%Y').to_s).utc.iso8601
      expect(Dataset::Xml.convert_date_for_solr(clean_mm_yyyy)).to eq(dt)
    end

    it 'returns valid DateTime for m/yyyy' do
      dt = Time.parse(DateTime.strptime(clean_m_yyyy, '%m/%Y').to_s).utc.iso8601
      expect(Dataset::Xml.convert_date_for_solr(clean_m_yyyy)).to eq(dt)
    end

    it 'returns nil DateTime for dirty mm/dd/yyyy' do
      expect(Dataset::Xml.convert_date_for_solr(dirty_mm_dd_yyyy)).to eq(nil)
    end

    it 'returns nil DateTime for dirty mm/yyyy' do
      expect(Dataset::Xml.convert_date_for_solr(dirty_mm_yyyy)).to eq(nil)
    end

    it 'returns nil DateTime for dirty m/yyyy' do
      expect(Dataset::Xml.convert_date_for_solr(dirty_m_yyyy)).to eq(nil)
    end
  end
end