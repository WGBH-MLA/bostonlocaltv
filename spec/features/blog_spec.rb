require_relative '../support/validation_helper'
require 'spec_helper'

describe 'Blog Show Page', type: feature do
  it 'has content for the "About" page' do
    visit "blog/about"
    expect(page).to have_content('Welcome to the Boston TV News Digital Library')
  end
  it 'lists old blog pages' do
    visit 'blog'
    expect(page).to have_content('Boston Local TV News Project Launched!') # first
    expect(page).to have_content('New Videos Up from Digitize on Demand Program') # last
  end
  it 'does not list non-blog pages' do
    visit 'blog'
    expect(page).not_to have_content('Resources for Archivists') # only on home
  end

  Blog.all.each do |blog|
    path = "/blog/#{blog.path}"
    it "#{path} works" do
      visit path
      expect(page.status_code).to eq(200)
      expect_fuzzy_xml
    end
  end
end
