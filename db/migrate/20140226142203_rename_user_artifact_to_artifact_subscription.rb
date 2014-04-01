class RenameUserArtifactToArtifactSubscription < ActiveRecord::Migration
  def change
    rename_table :user_artifacts, :artifact_subscriptions 
  end
end
