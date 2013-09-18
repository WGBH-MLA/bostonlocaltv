require 'spec_helper'

describe "shopping_cart_items/index.html.erb" do
  before(:each) do
    assign(:shopping_cart_items, [
      stub_model(ShoppingCartItem,
        :shopping_cart => nil,
        :item => nil
      ),
      stub_model(ShoppingCartItem,
        :shopping_cart => nil,
        :item => nil
      )
    ])
  end

  it "renders a list of shopping_cart_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
