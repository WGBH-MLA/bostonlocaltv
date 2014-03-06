require 'spec_helper'

describe Admin::ArtifactsController, type: feature do
	render_views

	before(:each) do
		@user1 = create(:user)
		@user2 = create(:user)
		@user3 = create(:user)
	  @admin_user = AdminUser.create(email: "test123@test.com", password: "123SuperTest")
	  @artifact = create(:artifact)
	end

	describe "Artifact index" do
	  before(:each) do
			@artifact.request_digitization(@user1)
			@artifact.request_digitization(@user2)
	  	@artifact.request_digitization(@user3)
			visit admin_artifacts_path
	  	fill_in 'admin_user_email', :with => @admin_user.email
	  	fill_in 'admin_user_password', :with => @admin_user.password
	  	click_button 'Login'
	  end

	  it "shows the artifact in the index" do
	  	expect(page).to have_content(@artifact.solr_document_id)
	  end

	  it "when multiple requests on artifact are made, requests column updates" do
			within "tr#artifact_#{@artifact.id}" do
				expect(page).to have_content(@artifact.sponsorships.count)
			end
	  end

	  it "admin can see potential sponsors when viewing artifact in interface" do
			click_link "View"
			expect(page).to have_content(@user1.email)
	  end

    it "admin can see list of users who requested the artifact" do
      click_link "View"
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
      expect(page).to have_content(@user3.email)
    end

	  it "admin can make a user a sponsor of artifact" do
	  	click_link "View"
	  	first(:link, "Confirm sponsorship").click;
	  	save_and_open_page
			expect(page).to have_content("Confirmed/Sponsor")
	  end
	end
end
