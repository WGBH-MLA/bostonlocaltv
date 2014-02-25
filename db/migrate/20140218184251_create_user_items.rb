class CreateUserItems < ActiveRecord::Migration
  def change
    create_table :user_items do |t|
      t.integer :user_id
      t.string :solr_document_id
      t.string :status

      t.timestamps
    end
  end
end
