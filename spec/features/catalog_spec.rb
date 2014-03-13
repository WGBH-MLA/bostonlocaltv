require 'spec_helper'

describe 'Catalog Show Page', type: feature do
	before(:each) do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    @artifact = create(:artifact)

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

  it "visits artifact catalog page" do
    visit "catalog/#{@artifact.solr_document_id}"
    save_and_open_page
  end
end
