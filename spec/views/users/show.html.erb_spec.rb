require 'spec_helper'

describe "users/show.html.erb" do
  before(:each) do
    @user = create(:user)
    assign(:user, @user)
  end

  it "displays the user's name and email" do
    render
    expect(rendered).to match /#{@user.first_name}/
    expect(rendered).to match /#{@user.last_name}/
    expect(rendered).to match /#{@user.email}/
  end
end
