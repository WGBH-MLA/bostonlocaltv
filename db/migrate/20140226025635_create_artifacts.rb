class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.string :state
      t.timestamps
    end
  end
end
