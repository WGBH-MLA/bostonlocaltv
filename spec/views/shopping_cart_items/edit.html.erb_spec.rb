require 'spec_helper'

describe "shopping_cart_items/edit.html.erb" do
  before(:each) do
    @shopping_cart_item = assign(:shopping_cart_item, stub_model(ShoppingCartItem,
      :shopping_cart => nil,
      :item => nil
    ))
  end

  it "renders the edit shopping_cart_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shopping_cart_items_path(@shopping_cart_item), :method => "post" do
      assert_select "input#shopping_cart_item_shopping_cart", :name => "shopping_cart_item[shopping_cart]"
      assert_select "input#shopping_cart_item_item", :name => "shopping_cart_item[item]"
    end
  end
end
