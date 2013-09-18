class AddStatusToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :status, :string, default: 'open'
  end
end
