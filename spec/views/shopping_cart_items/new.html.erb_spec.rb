require 'spec_helper'

describe "shopping_cart_items/new.html.erb" do
  before(:each) do
    assign(:shopping_cart_item, stub_model(ShoppingCartItem,
      :shopping_cart => nil,
      :item => nil
    ).as_new_record)
  end

  it "renders new shopping_cart_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shopping_cart_items_path, :method => "post" do
      assert_select "input#shopping_cart_item_shopping_cart", :name => "shopping_cart_item[shopping_cart]"
      assert_select "input#shopping_cart_item_item", :name => "shopping_cart_item[item]"
    end
  end
end
