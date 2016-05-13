Bostonlocaltv::Application.routes.draw do

  resources :collections

  Blacklight.add_routes(self)

  root :to => "catalog#home"

  match 'catalog/citation', :as => "citation_catalog"
 
  get ':id', to: 'collections#show', constraints: { id: /wgbh|whdh|wcvb|cctv/ }
  
  # I believe the constraint is to allow PID variations in the id.
  resources :catalog, :only => [:index, :show], :constraints => { :id=>/([A-Za-z0-9]|:|-|\.)*([A-Za-z0-9]|:|-){7}/ } do

    # TODO: is this used anywhere
    member do
      get 'cite'
    end
  end
  
  resources 'oai',
            only: [:index]

  get 'blog/*path', to: 'blog#show'
end
