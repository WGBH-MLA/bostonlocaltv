require 'spec_helper'

describe ShoppingCart do
  before :each do
    @user = create(:user)
  end
  
  it "has a valid factory" do
    create(:shopping_cart, :user_id => @user.id).should be_valid
  end
  
  it "is invalid without a user_id" do
    build(:shopping_cart, user_id: nil).should_not be_valid
  end
  
end
