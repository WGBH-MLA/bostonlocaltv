require 'spec_helper'

describe UserItem do

  it "has a valid factory" do
    create(:user_item).should be_valid
  end
  
  it "is invalid without User" do
    build(:user_item, user: nil).should_not be_valid
  end
end
