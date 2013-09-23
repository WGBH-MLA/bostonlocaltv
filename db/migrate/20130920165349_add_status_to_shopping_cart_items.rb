class AddStatusToShoppingCartItems < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :status, :string
    add_column :shopping_cart_items, :completed, :boolean, default: false
  end
end
