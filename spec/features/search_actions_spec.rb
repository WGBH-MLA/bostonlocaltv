require 'spec_helper'

feature 'Search' do
  
  # TODO: make this test stronger.
  scenario "User performs a search and sees search results page." do
    visit '/'
    fill_in 'q', with: "foo"
    click_button 'search'
    expect(page).to have_css "#documents"
  end
  
end