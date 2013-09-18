require 'spec_helper'

describe "shopping_carts/new.html.erb" do
  before(:each) do
    assign(:shopping_cart, stub_model(ShoppingCart,
      :user => nil,
      :item => nil,
      :settled => false
    ).as_new_record)
  end

  it "renders new shopping_cart form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => shopping_carts_path, :method => "post" do
      assert_select "input#shopping_cart_user", :name => "shopping_cart[user]"
      assert_select "input#shopping_cart_item", :name => "shopping_cart[item]"
      assert_select "input#shopping_cart_settled", :name => "shopping_cart[settled]"
    end
  end
end
