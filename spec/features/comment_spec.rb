require 'spec_helper'

describe 'Comments', type: feature do
  before(:each) do
    YAML::ENGINE.yamler = 'syck'
    solr_fixture_file = File.dirname(__FILE__) + "/../fixtures/solr_response.yml"
    solr_response = YAML::load_file(solr_fixture_file)

    solr_fixture_file_r = File.dirname(__FILE__) + "/../fixtures/solr_response_r.yml"
    solr_response_r = YAML::load_file(solr_fixture_file_r)

    solr_fixture_file_docs = File.dirname(__FILE__) + "/../fixtures/solr_response_docs.yml"
    solr_response_docs = YAML::load_file(solr_fixture_file_docs)

    solr_response.stub(:response) {solr_response_r}
    solr_response.stub(:docs) {solr_response_docs}
    Blacklight::SolrResponse.stub(:new) {solr_response}
  end

  it "artifact has a comment field" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    @artifact = create(:artifact, solr_document_id: "V_GOMVH1RTSRIM6L6")
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit "catalog/V_GOMVH1RTSRIM6L6"
    within ('.new_comment') do
      expect(page).to have_content("Post a new comment")
    end
  end

  it "user can submit a new comment" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    @artifact = create(:artifact, solr_document_id: "V_GOMVH1RTSRIM6L6")
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit "catalog/V_GOMVH1RTSRIM6L6"
    within ('.new_comment') do
      fill_in "comment_comment", :with => "I am impressed to see this item in the WGBH collection."
    end
    click_button "Comment"
    expect(page).to have_content("(1 Comment waiting approval)")
  end

  it "approved comments show on the page" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    @artifact = create(:artifact, solr_document_id: "V_GOMVH1RTSRIM6L6")
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit "catalog/V_GOMVH1RTSRIM6L6"
    within ('.new_comment') do
      fill_in "comment_comment", :with => "I am impressed to see this item in the WGBH collection."
    end
    click_button "Comment"
    @comment = Comment.last
    @comment.approve!
    @comment.save
    visit "V_GOMVH1RTSRIM6L6"
    expect(page).to have_content("I am impressed to see this")
  end

  it "when comment is approved it should change the # of comments waiting approval shown on page" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    @artifact = create(:artifact, solr_document_id: "V_GOMVH1RTSRIM6L6")
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit "catalog/V_GOMVH1RTSRIM6L6"
    within ('.new_comment') do
      fill_in "comment_comment", :with => "I am impressed to see this item in the WGBH collection."
    end
    click_button "Comment"
    @comment = Comment.last
    @comment.approve!
    @comment.save
    visit "V_GOMVH1RTSRIM6L6"
    expect(page).to have_content("(0 Comments waiting approval)")
  end

  it "blocked comments do not show on the page" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    @artifact = create(:artifact, solr_document_id: "V_GOMVH1RTSRIM6L6")
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit "catalog/V_GOMVH1RTSRIM6L6"
    within ('.new_comment') do
      fill_in "comment_comment", :with => "I am impressed to see this item in the WGBH collection."
    end
    click_button "Comment"
    @comment = Comment.last
    @comment.block!
    @comment.save
    visit "V_GOMVH1RTSRIM6L6"
    expect(page).to have_no_content("I am impressed to see this")
  end
end