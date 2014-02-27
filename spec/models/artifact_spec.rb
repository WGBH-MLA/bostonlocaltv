require 'spec_helper'

describe Artifact do

	before do
		@user = create(:user)
		@artifact = create(:artifact)
	end

	describe "states" do

		it "should change artifact's state from initiated to requested when user requests digitization" do
			@artifact.request_digitization(@user)
			@artifact.state.should == "requested"
		end

		it "should change artifact's state from requested to digitizing when admin approves request" do
			@artifact.request_digitization(@user)
			@artifact.digitize(@user)
			@artifact.state.should == "digitizing"
		end

		it "should change artifact's state from requested to denied when admin denies request" do
			@artifact.request_digitization(@user)
			@artifact.deny(@user)
			@artifact.state.should == "denied"
		end

		it "artifact saves state of requested after multiple users request digitization" do 
			@user2 = create(:user)
			@user3 = create(:user)
			@artifact.request_digitization(@user)
			@artifact.request_digitization(@user2)
			@artifact.request_digitization(@user3)
			@artifact.state.should == "requested"
		end

	end

end
