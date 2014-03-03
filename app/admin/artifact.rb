ActiveAdmin.register Artifact do     
  index do                            
    column :solr_document_id
    column :created_at
    default_actions                   
  end                                 

  show do
    attributes_table do
      row :id
      row :state
      row :created_at
      row :potential_sponsors do
        artifact.potential_sponsors.collect{|s| s.to_s}.join(', ')
      end
      row :sponsors do
        artifact.sponsors.collect{|s| s.to_s}.join(', ')
      end
    end

    active_admin_comments
  end
end                                   
