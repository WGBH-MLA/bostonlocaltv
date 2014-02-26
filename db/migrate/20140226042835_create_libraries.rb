class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.integer :artifact_id
      t.integer :user_id
      t.timestamps
    end
  end
end
