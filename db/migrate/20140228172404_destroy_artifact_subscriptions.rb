class DestroyArtifactSubscriptions < ActiveRecord::Migration
  def change
  	drop_table :artifact_subscriptions
  end
end
