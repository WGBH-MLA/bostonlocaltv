require 'spec_helper'
require 'nokogiri'

describe CatalogController do
  describe 'GET oai' do
    it 'responds with OAI-PMH xml' do
      get 'oai'
      ng = Nokogiri::XML(response.body)
      oai_ns = ng.namespaces.key "http://www.openarchives.org/OAI/2.0/"
      expect(ng.xpath("//#{oai_ns}:OAI-PMH")).to_not be_empty
    end
  end
end 