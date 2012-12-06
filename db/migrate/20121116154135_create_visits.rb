class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :item_id
      t.string :title
      t.integer :visits

      t.timestamps
    end
  end
end
