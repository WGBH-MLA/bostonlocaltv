require 'spec_helper'

describe 'Catalog Show Page', type: feature do
  before(:all) do
    # TODO: This is just a copy and paste from .travis.yml. Should not rely on back-ticks
    `for ORG in cctv wcvb wgbh whdh; do bundle exec rake data:$ORG file=spec/fixtures/xml/$ORG.pbcore.xml; done`
  end
  
  it 'has a working #index with no params' do
    visit 'catalog'
    expect(page).to have_content('Try one of these subjects to get started')
  end
  
  it 'has a working #index with default' do
    visit 'catalog?search_field=all_fields'
    expect(page).to have_content('1 entry found')
    expect(page).to have_content("Collection: Ten O'Clock News")
  end
  
  it 'has a working #index with params' do
    visit 'catalog?non_video=yes&search_field=all_fields'
    expect(page).to have_content('1 - 4 of 4')
    expect(page).to have_content('Collection: WHDH')
    expect(page).to have_content('Collection: CCTV')
    expect(page).to have_content('Collection: WCVB Collection')
    expect(page).to have_content("Collection: Ten O'Clock News")
  end
  
  it 'has a working #show' do
    visit '/catalog/V_T4G0B5DQISU2FGC'
    expect(page).to have_content('South Boston High School')
  end
end
