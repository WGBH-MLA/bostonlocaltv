require 'spec_helper'

describe "votes/edit.html.erb" do
  before(:each) do
    @vote = assign(:vote, stub_model(Vote,
      :item_id => "MyString",
      :user_id => "MyString"
    ))
  end

  it "renders the edit vote form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => votes_path(@vote), :method => "post" do
      assert_select "input#vote_item_id", :name => "vote[item_id]"
      assert_select "input#vote_user_id", :name => "vote[user_id]"
    end
  end
end
