require "spec_helper"

describe AdminMailer do
	before do
	  @user = create(:user)
  	@artifact = create(:artifact)
  	@artifact.request!(@user)
  	@artifact.save
  end

  it "should email an admin when a request is made" do
  	ActionMailer::Base.deliveries.last.to.should == ["bostonlocaltv@wgbh.org"]
  end

  it "should email an admin when a request is withdrawn" do
  	@artifact.withdraw_request(@user)
  	ActionMailer::Base.deliveries.last.subject.should == "Digitization Request Withdrawn"
  end

end
