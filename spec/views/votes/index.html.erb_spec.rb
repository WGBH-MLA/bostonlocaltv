require 'spec_helper'

describe "votes/index.html.erb" do
  before(:each) do
    assign(:votes, [
      stub_model(Vote,
        :item_id => "Item",
        :user_id => "User"
      ),
      stub_model(Vote,
        :item_id => "Item",
        :user_id => "User"
      )
    ])
  end

  it "renders a list of votes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Item".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
