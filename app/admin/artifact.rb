ActiveAdmin.register Artifact do   
  config.filters = true

  filter :email
  filter :first_name
  filter :solr_document_id
  filter :created_at
  filter :updated_at
  filter :state
  filter :sponsorship_user_ids, :as => :select, :collection => User.all.collect{|u| [u.to_s, u.id]}, :label => 'Requestor / Sponsor'

  index do
    column :id
    column :solr_document_id
    column :created_at
    column :updated_at
    column :state
    column :requests do |artifact|
      artifact.sponsorships.count
    end
    default_actions                   
  end                                 

  show do |artifact|
    attributes_table do
      row :id
      row :solr_document_id
      row :state
      row :created_at
      row :potential_sponsors do
        artifact.potential_sponsors.collect{|s| s.to_s}.join(', ')
      end
      row :sponsors do
        artifact.sponsors.collect{|s| s.to_s}.join(', ')
      end
      row :actions do 
        if artifact.state == "requested" || artifact.state == "initiated"
          links = []
          links << link_to("Digitize", approve_digitization_admin_artifact_path(artifact), :method => :put, :class => "approve_digitization")
          links << link_to("Block", block_digitization_admin_artifact_path(artifact), :method => :put, :class => "block_digitization")
          links.join(' / ').html_safe
        elsif artifact.state == "digitizing"
          "Digitization has been approved and artifact is being digitized"
        else
          "Issue, please contact support"
        end
      end
    end

    panel "Requests" do
      table_for artifact.sponsorships do
        column :email do |sponsorship|
          link_to sponsorship.user.email, admin_user_path(sponsorship.user.id)
        end
        column :status do |sponsorship|
          sponsorship.status
        end
        column :actions do |sponsorship|
          if sponsorship.confirmed?
            link_to "Remove sponsorship", unconfirm_sponsorship_path(sponsorship), :method => :put
          else
            link_to "Confirm sponsorship", confirm_sponsorship_path(sponsorship), :method => :put
          end
        end
      end
    end

    active_admin_comments
  end

  member_action :approve_digitization, :method => :put do
    artifact = Artifact.find(params[:id])
    artifact.digitize(current_user)
    redirect_to admin_artifact_url(artifact)
  end

  member_action :block_digitization, :method => :put do
    artifact = Artifact.find(params[:id])
    artifact.block(current_user)
    redirect_to admin_artifact_url(artifact)
  end
end                                   
