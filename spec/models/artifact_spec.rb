require 'spec_helper'

describe Artifact do

	before do
		@user = create(:user)
		@user2 = create(:user)
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
			@user3 = create(:user)
			@artifact.request_digitization(@user)
			@artifact.request_digitization(@user2)
			@artifact.request_digitization(@user3)
			@artifact.state.should == "requested"
		end

		it "should return artifact's state to initiated if last request is withdrawn" do 
			@artifact.request_digitization(@user)
			@artifact.request_digitization(@user2)
			@artifact.withdraw_request(@user)
			@artifact.withdraw_request(@user2)
			@artifact.state.should == "initiated"
		end

		it "should keep artifact's state as 'requested' if a request is withdrawn but there are other remaining requests" do 
			@artifact.request_digitization(@user)
			@artifact.request_digitization(@user2)
			@artifact.withdraw_request(@user)
			@artifact.state.should == "requested"
		end
	end

	describe "sponsors" do

		it 'should make a user who requests an artifact a potential sponsor' do
			@artifact.request_digitization(@user)
			@artifact.potential_sponsors.should include(@user)
		end

		it 'should not make user a confirmed sponsor upon artifact request' do
			@artifact.request_digitization(@user)
			@artifact.sponsors.should_not include(@user)
		end

		it "should remove user from artifact sponsors if artifact request is withdrawn" do
			@artifact.request_digitization(@user)
			@artifact.withdraw_request(@user)
			@artifact.reload
			@artifact.potential_sponsors.should_not include(@user)
		end

		it "should remove user's potential sponsorship if artifact request is withdrawn" do
			@artifact.request_digitization(@user)
			@user.artifacts.reload # simulates user touching/loading/caching the relationship
			@artifact.withdraw_request(@user)
			@user.artifacts.should == []
		end

	end	

end
