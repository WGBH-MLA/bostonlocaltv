require 'spec_helper'

describe 'Blog Show Page', type: feature do
  it 'has content for the "About" page' do
    visit "blog/about"
    expect(page).to have_content('Welcome to the Boston TV News Digital Library')
  end
end