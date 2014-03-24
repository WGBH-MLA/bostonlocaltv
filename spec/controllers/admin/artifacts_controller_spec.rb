require 'spec_helper'
include Devise::TestHelpers

describe Admin::ArtifactsController, type: feature do
	render_views

  def login(user)
    visit new_user_session_path
    fill_in 'Email', :with => @admin.email
    fill_in 'Password', :with => @admin.password
    click_button 'Sign in'
  end

	before(:each) do
		@user1 = create(:user)
		@user2 = create(:user)
		@user3 = create(:user)
	  @admin = create(:admin)
	  @artifact = create(:artifact)
	end

	describe "Artifact index" do
	  before(:each) do
			@artifact.request_digitization(@user1)
      login(@admin)
      visit admin_artifacts_path
	  end

	  it "shows the artifact in the index" do
	  	expect(page).to have_content(@artifact.solr_document_id)
	  end

	  it "when multiple requests on artifact are made, requests column updates" do
			within "tr#artifact_#{@artifact.id}" do
				expect(page).to have_content(@artifact.sponsorships.count)
			end
	  end
	end

  describe "Artifact show" do
    before(:each) do
      @artifact.request_digitization(@user1)
      @artifact.request_digitization(@user2)
      @artifact.request_digitization(@user3)
      login(@admin)
      visit admin_artifacts_path
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
      expect(page).to have_content("Confirmed/Sponsor")
    end

    it "admin can withdraw a user's request" do
      click_link "View"
      first(:link, "Withdraw user's request").click;
      expect(page).to have_no_content(@user1.email)
    end

    it "admin can withdraw a user's request and other requests should still be there" do
      click_link "View"
      first(:link, "Withdraw user's request").click;
      expect(page).to have_content(@user2.email)
    end

    it "shows 'digitize' action link when artifact hasn't been digitized" do 
      click_link "View"
      within ".attributes_table" do
        expect(page).to have_css(".approve_digitization")
      end
    end

    it "clicking 'digitze' link changes artifact state to digitizing" do
      click_link "View"
      within ".attributes_table" do
        click_link("Digitize")
      end
      within ".attributes_table" do
        expect(page).to have_content("Digitization has been approved")
      end
    end

    it "when artifact state is 'digitizing', there should be no 'digitize' link" do
      @artifact.approve_digitization(@admin)
      click_link "View"
      within ".attributes_table" do
        expect(page).not_to have_css(".approve_digitization")
      end
    end

    it "clicking 'block' link changes artifact state to blocked" do
      click_link "View"
      within ".attributes_table" do
        click_link("Block")
      end
      within ".attributes_table" do
        expect(page).to have_content("We are unable to digitize this artifact")
      end
    end

    it "clicking 'digitze' link changes makes the 'Publish' link available" do
      click_link "View"
      within ".attributes_table" do
        click_link("Digitize")
      end
      within ".attributes_table" do
        expect(page).to have_content("Publish This Artifact")
      end
    end

    it "clicking 'publish' link changes artifact state to published" do
      click_link "View"
      within ".attributes_table" do
        click_link("Digitize")
      end
      within ".attributes_table" do 
        click_link('Publish This Artifact')
      end
      within ".attributes_table" do
        expect(page).to have_content("This artifact has been published and is available.")
      end
    end

    it "when artifact state is 'requested', there should be no 'publish' link" do
      click_link "View"
      within ".attributes_table" do
        expect(page).not_to have_css(".publish_digitization")
      end
    end

    it "when artifact state is 'blocked', there should be no 'publish' link" do
      @artifact.block_digitization(@admin)
      click_link "View"
      within ".attributes_table" do
        expect(page).not_to have_css(".publish_digitization")
      end
    end

    it "when artifact state is 'blocked', there should be no 'block' link" do
      @artifact.block_digitization(@admin)
      click_link "View"
      within ".attributes_table" do
        expect(page).not_to have_css(".block_digitization")
      end
    end
  end
end
