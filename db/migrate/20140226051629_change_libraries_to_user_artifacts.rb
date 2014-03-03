class ChangeLibrariesToUserArtifacts < ActiveRecord::Migration
  def change
  	rename_table :libraries, :user_artifacts
  end
end
