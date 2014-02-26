require "spec_helper"

describe UserMailer do
	before do
	  @user = create(:user)
  	artifact = create(:artifact)
  	artifact.request!(@user)
  	artifact.save
  	artifact.approve!
  end

  it "should email a user when a request is approved by an admin" do
  	ActionMailer::Base.deliveries.last.to.should == [@user.email]
  end
end