require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature 'User adds an item to their cart' do
  
  before :each do
    Capybara.reset_sessions!
    @user = create(:user)
  end
  
  scenario "when a user is not signed in and tries to add an item to the cart" # do
 #    visit '/catalog/BPL_2SZI4PLIK5KVA81'
 #    #save_and_open_page
 #    click_link 'Add to cart'
 #    expect(page).to have_content('You must be signed in to add items to your cart.')
 #  end
  
  scenario "when a user is logged in and tries to add an item to the cart"
  
  scenario "when a logged in user submits their cart"
  
  scenario "when a logged in user empties their cart"
  
  scenario "when a logged in user removes and item from their cart"
  
end