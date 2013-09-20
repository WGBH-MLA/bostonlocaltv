require 'spec_helper'

describe "shopping_cart_items/show.html.erb" do
  before(:each) do
    @shopping_cart_item = assign(:shopping_cart_item, stub_model(ShoppingCartItem,
      :shopping_cart => nil,
      :item => nil
    ))
  end

  pending "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
