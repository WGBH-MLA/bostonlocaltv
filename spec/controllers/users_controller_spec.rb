require 'spec_helper'

describe UsersController do

  describe "GET show" do

    it 'assigns @user' do
      @user = FactoryGirl.create(:user)
      sign_in @user
      get :show
      expect(assigns(:user)).to eq @user
    end
  
  end
end