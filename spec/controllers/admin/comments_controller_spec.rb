require 'spec_helper'
include Devise::TestHelpers

describe Admin::CommentsController, type: feature do
	render_views

  def login(user)
    visit new_user_session_path
    fill_in 'Email', :with => @admin.email
    fill_in 'Password', :with => @admin.password
    click_button 'Sign in'
  end

	before(:each) do
		@user = create(:user)
	  @admin = create(:admin)
    @comment = create(:comment, :user_id => @user)
	end

	describe "Comment index" do
	  before(:each) do
      login(@admin)
      visit admin_comments_path
	  end

	  it "shows comments in the index" do
	  	expect(page).to have_content(@user.full_name)
	  end

    it "admin can click approve on comment to change the state to approved" do
      click_link "Approve"
      expect(page).to have_content("true")
    end

    it "admin can click block on an approved comment to change the state to blocked" do
      click_link "Approve"
      click_link "Block"
      expect(page).to have_no_content("true")
    end
	end
end
