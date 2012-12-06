class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_id
#      t.remove :id
      t.timestamps
    end
  end
end
