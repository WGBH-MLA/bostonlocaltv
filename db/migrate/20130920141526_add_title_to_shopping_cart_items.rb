class AddTitleToShoppingCartItems < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :title, :string
  end
end
