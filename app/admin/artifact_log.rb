ActiveAdmin.register ArtifactLog do     
  menu :priority => 2
  index do                            
    column :user
    column :artifact
    column :event
    column :from
    column :to
    column :description
    column :created_at
    default_actions
  end                                 

  filter :email
  filter :event
  filter :created_at
end                                   
