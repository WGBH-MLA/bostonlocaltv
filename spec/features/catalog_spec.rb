require 'spec_helper'

describe 'Catalog Show Page', type: feature do
  it 'has a working #index' do
    visit 'catalog?non_video=yes&search_field=all_fields'
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
