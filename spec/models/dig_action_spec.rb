require 'spec_helper'

describe DigAction do
  
  it "has a valid factory" do
    create(:dig_action).should be_valid
  end
  
  it "is invalid without UserItem" do
    build(:dig_action, user_item: nil).should_not be_valid
  end
  
  it "is invalid without type" do
    build(:dig_action, type: nil).should_not be_valid
  end

end
