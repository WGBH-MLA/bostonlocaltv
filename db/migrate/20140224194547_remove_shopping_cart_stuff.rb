class RemoveShoppingCartStuff < ActiveRecord::Migration
  def up
    drop_table(:shopping_carts)
	drop_table(:shopping_cart_items)
  end

  def down
    create_table :shopping_carts do |t|
      t.references :user
      t.boolean :settled, default: false

      t.timestamps
    end
    add_index :shopping_carts, :user_id

    create_table :shopping_cart_items do |t|
      t.references :shopping_cart
      t.string :solr_document_id

      t.timestamps
    end
    add_index :shopping_cart_items, :shopping_cart_id
    add_index :shopping_cart_items, :solr_document_id

  end

end
