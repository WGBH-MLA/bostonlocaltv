require 'spec_helper'

describe "shopping_carts/index.html.erb" do
  before(:each) do
    assign(:shopping_carts, [
      stub_model(ShoppingCart,
        :user => nil,
        :item => nil,
        :settled => false
      ),
      stub_model(ShoppingCart,
        :user => nil,
        :item => nil,
        :settled => false
      )
    ])
  end

  pending "renders a list of shopping_carts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
