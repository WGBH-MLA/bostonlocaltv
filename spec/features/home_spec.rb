require 'spec_helper'

describe 'Home Page', type: feature do
  it 'has expected home page' do
    visit "/"
    expect(page).to have_content('Welcome to the Boston TV News Digital Library')
  end
end