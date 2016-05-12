require 'spec_helper'

describe 'Collections', type: feature do
  %w{wcvb cctv whdh wgbh}.each do |collection|
    it "renders /#{collection}" do
      visit collection
      expect(page).to have_content('All materials')
    end
  end
end