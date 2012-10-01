require 'spec_helper'

describe "votes/show.html.erb" do
  before(:each) do
    @vote = assign(:vote, stub_model(Vote,
      :item_id => "Item",
      :user_id => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Item/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
  end
end
