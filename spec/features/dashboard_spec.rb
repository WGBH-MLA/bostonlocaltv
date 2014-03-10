require 'spec_helper'

describe 'User dashboard', type: feature do
	 before(:all) do
    @user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
  end

  it "shows user's name on their dashboard" do
  	visit dashboard_path
  	expect(page).to have_content(@user.first_name)
  end

end