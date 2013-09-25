require 'spec_helper'

describe ShoppingCartItem do
  before :each do
    @user = create(:user)
    @cart = create(:shopping_cart, :user_id => @user.id)
    @solr_doc_id = 'BPL_0O36FFSOSYHZTQQ'
  end
  
  it "has a valid factory" do
    create(:shopping_cart_item, :shopping_cart_id => @cart.id, :solr_document_id => @solr_doc_id).should be_valid
  end
  
  it "is invalid without a shopping cart and solr document id" do
    build(:shopping_cart_item).should_not be_valid
  end
  
end
