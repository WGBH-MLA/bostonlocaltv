class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_body_class

  def show
    @user = current_user
  end

  def edit
  end

  def set_body_class
    @body_class = 'dashboard'
  end
  
end
