require 'spec_helper'

describe 'User dashboard', type: feature do
	 before(:each) do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    @artifact = create(:artifact)
    @artifact.stub(:title).and_return('Title Stub')
    @artifact.request_digitization(@user)
    @sponsorship = @user.sponsorships.first
    visit dashboard_path
  end

  it "shows artifacts they have requested", wip: true do
    @sponsorship.stub(:artifact).and_return(@artifact)
    User.any_instance.stub(:sponsorships).and_return([@sponsorship])
    visit dashboard_path
    expect(page).to have_content(@artifact.title)
  end

  it "shows user's name on their dashboard" do
  	expect(page).to have_content(@user.first_name)
  end

  it "shows digitization status of 'requested' when user has requested artifact" do
    within("#sponsorship-#{@sponsorship.id} .state") do
      expect(page).to have_content("requested")
    end
  end

  it "shows user status of 'following' when user has requested artifact" do
    within("#sponsorship-#{@sponsorship.id} .status") do
      expect(page).to have_content("Following")
    end
  end

  it "shows option to to 'unfollow' requested artifact" do
    within("#sponsorship-#{@sponsorship.id} .actions") do
      expect(page).to have_content("Unfollow")
    end
  end

  it "shows digitization status of 'digitizing' when artifact is digitizing" do
    @artifact.approve_digitization(@user)
    visit dashboard_path
    within("#sponsorship-#{@sponsorship.id} .state") do
      expect(page).to have_content("digitizing")
    end
  end

  it "shows digitization status of 'denied' when digitization has been denied" do
    @artifact.block(@user)
    visit dashboard_path
    within("#sponsorship-#{@sponsorship.id} .state") do
      expect(page).to have_content("blocked")
    end
  end

  it "shows user status of 'Confirmed/Sponsor' when user is a confirmed sponsor" do
    @sponsorship.confirm!
    visit dashboard_path
    within("#sponsorship-#{@sponsorship.id} .status") do
      expect(page).to have_content("Confirmed/Sponsor")
    end
  end

  it "doesn't show action 'Unfollow' when user is a confirmed sponsor and artifact is digitizing" do
    @sponsorship.confirm!
    @artifact.approve_digitization(@user)
    visit dashboard_path
    within("#sponsorship-#{@sponsorship.id} .actions") do
      expect(page).to have_content("")
    end
  end

  it "clicking 'Unfollow' removes artifact from dashboard" do
    click_link("Unfollow")
    expect(page).not_to have_content(@artifact.title)
  end

  it "shows digitization status of 'published' when digitization has been published" do
    @artifact.approve_digitization(@user)
    @artifact.publish(@user)
    visit dashboard_path
    within("#sponsorship-#{@sponsorship.id} .state") do
      expect(page).to have_content("published")
    end
  end
end
