class AddTitleToVote < ActiveRecord::Migration
  def self.up
    add_column :votes, :title, :string
  end

  def self.down
    remove_column :votes, :title
  end
end
