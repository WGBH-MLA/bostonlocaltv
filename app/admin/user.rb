ActiveAdmin.register User do
	filter :first_name
	filter :last_name
	filter :email
  filter :created_at

  index do
    id_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :requests do |user|
      user.artifacts.count
    end
    column :admin
    default_actions
  end

  show do |user|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :created_at
      row :admin
    end
    panel "Requests" do
      table_for user.sponsorships do
        column :id do |sponsorship|
          link_to sponsorship.artifact.id, admin_artifact_path(sponsorship.artifact)
        end
        column :solr_document_id do |sponsorship|
          sponsorship.artifact.solr_document_id
        end
        column :state do |sponsorship|
          sponsorship.artifact.state
        end
        column :status
        column :created_at
      end
    end
  end

end
