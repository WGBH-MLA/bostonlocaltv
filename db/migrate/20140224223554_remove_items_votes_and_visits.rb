class RemoveItemsVotesAndVisits < ActiveRecord::Migration
  def up
    drop_table(:items)
    drop_table(:votes)
    drop_table(:visits)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
