require 'spec_helper'

describe 'OAI', type: feature do
  it 'works' do
    visit "/oai.xml?verb=ListRecords"
    expect(page.status_code).to eq(200)
    expect { REXML::Document.new(page.body) }.not_to raise_error
    [
      '<OAI-PMH', # Followed by NS
      '<request verb="ListRecords" metadataPrefix="mods">http://bostonlocaltv.org/oai.xml</request>',
      '<ListRecords>',
      '<identifier type="uri">http://bostonlocaltv.org/catalog/V_K5LZAN8YMD1MVIY</identifier>',
      '<title>Bank headquarters and Gillette</title>'
    ].each do |s|
      expect(page.body).to match s
    end
  end
end