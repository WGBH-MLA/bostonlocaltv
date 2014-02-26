class AddSolrDocIdToArtifact < ActiveRecord::Migration
  def change
  	add_column :artifacts, :solr_document_id, :string
  end
end
