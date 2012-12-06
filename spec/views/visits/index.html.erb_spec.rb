require 'spec_helper'

describe "visits/index.html.erb" do
  before(:each) do
    assign(:visits, [
      stub_model(Visit,
        :item_id => "Item",
        :title => "Title",
        :visits => 1
      ),
      stub_model(Visit,
        :item_id => "Item",
        :title => "Title",
        :visits => 1
      )
    ])
  end

  it "renders a list of visits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Item".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
