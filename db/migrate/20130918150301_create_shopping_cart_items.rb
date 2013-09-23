class CreateShoppingCartItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.references :shopping_cart
      t.string :solr_document_id

      t.timestamps
    end
    add_index :shopping_cart_items, :shopping_cart_id
    add_index :shopping_cart_items, :solr_document_id
  end
end
