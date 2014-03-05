require 'spec_helper'
include Devise::TestHelpers

describe Admin::ArtifactsController, type: feature do
	render_views

	before(:each) do
		@user = create(:user)
	  @admin_user = AdminUser.create(email: "test123@test.com", password: "123SuperTest")
	  @artifact = create(:artifact)
	end

	describe "Artifact index" do
	  before(:each) do
			@artifact.request_digitization(@user)
	  end

	  it "shows the artifact in the index" do
	  	visit admin_artifacts_path
	  	fill_in 'admin_user_email', :with => @admin_user.email
	  	fill_in 'admin_user_password', :with => "123SuperTest"
	  	click_button 'Login'
	  	expect(page).to have_content(@artifact.solr_document_id)
	  end
	end
end
