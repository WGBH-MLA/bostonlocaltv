class AddVotesToItems < ActiveRecord::Migration
  def change
    add_column :items, :votes_count, :integer
  end
end
