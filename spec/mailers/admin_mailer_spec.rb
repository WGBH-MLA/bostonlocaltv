require "spec_helper"

describe AdminMailer do
	before do
	  @user = create(:user)
  	artifact = create(:artifact)
  	artifact.request!(@user)
  	artifact.save
  end

  it "should email an admin when a request is made" do
  	ActionMailer::Base.deliveries.last.to.should == ["bostonlocaltv@wgbh.org"]
  end

end
