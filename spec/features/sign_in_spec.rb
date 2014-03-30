require 'spec_helper'

describe 'User sign in process', type: feature do
  it 'Someone without an account is denied' do
    visit new_user_session_path
    fill_in 'Email', :with => 'test@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    expect(page).to have_content('Invalid email or password')
  end

  it 'Allows a user to sign in' do
    user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully')
  end

  it 'Allows a user to sign out' do
    user = create(:user, :password => 'password', :password_confirmation => 'password')
    visit new_user_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'password'
    click_button 'Sign in'
    click_link 'Logout'
    expect(page).to have_content('Signed out successfully')
  end
end
