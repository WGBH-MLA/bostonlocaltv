require 'spec_helper'

describe 'Catalog Show Page', type: feature do
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

  it "tells user artifact cannot be digitized if artifact was blocked" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'

    @artifact = create(:artifact)
    @artifact.request_digitization(@user)
    
    @artifact.block(@user)
    visit "catalog/#{@artifact.solr_document_id}"
    expect(page).to have_content("We are unable to digitize this item.")
  end

  it "tells the user they've already requested the artifact if they have an outstanding request on it", wip: true do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit "catalog/V_GOMVH1RTSRIM6L6"
    click_link 'Request digitization of this item'
    expect(page).to have_content("You have requested this item,")
  end

  it "gives user option to track artifact if it's already being digitized" do
    @user1 = create(:user, :password => 'password', :password_confirmation => 'password')
    @artifact = create(:artifact, solr_document_id: "V_GOMVH1RTSRIM6L6")
    @artifact.request_digitization(@user1)
    @artifact.approve_digitization(@user1)

    @user2 = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => @user2.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    
    visit "catalog/#{@artifact.solr_document_id}"

    expect(page).to have_content("Track")
  end

  it "displays 'request' option if artifact is not blocked and user has not requested it before" do 
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    visit "catalog/V_GOMVH1RTSRIM6L6"
    expect(page).to have_content("Request digitization of this item")
  end

  it "shows user the log in or sign up links if they are not logged in" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit "catalog/V_GOMVH1RTSRIM6L6"
    within ('.artifact_status') do
      expect(page).to have_content("Please log in or sign up to request this item")
    end
  end

  it "shows no message if the artifact has been published" do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    @artifact = create(:artifact, solr_document_id: "V_GOMVH1RTSRIM6L6")
    @artifact.request_digitization(@user)
    @artifact.approve_digitization(@user)
    @artifact.publish_digitization(@user)
    visit "catalog/V_GOMVH1RTSRIM6L6"
    within ('.artifact_status') do
      expect(page).to have_no_content("item")
    end
  end

end
