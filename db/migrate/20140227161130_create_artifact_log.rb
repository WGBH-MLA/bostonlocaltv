class CreateArtifactLog < ActiveRecord::Migration
  def change
    create_table :artifact_logs do |t|
      t.integer :artifact_id
      t.integer :user_id
      t.string :event
      t.string :from
      t.string :to
      t.text :description
      t.timestamps
    end
  end
end
