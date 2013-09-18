class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.references :user
      t.boolean :settled, default: false

      t.timestamps
    end
    add_index :shopping_carts, :user_id
  end
end
