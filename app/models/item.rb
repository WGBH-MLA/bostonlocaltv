class Item < ActiveRecord::Base
#    self.primary_key = "item_id"
    has_many :votes
    has_many :shopping_cart_items
end
