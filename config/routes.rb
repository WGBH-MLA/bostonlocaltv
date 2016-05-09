Bostonlocaltv::Application.routes.draw do

  resources :collections

  Blacklight.add_routes(self)

  root :to => "catalog#home"

  match 'catalog/citation', :as => "citation_catalog"
 
  get 'wgbh' => 'collections#wgbh', :as=> 'wgbh_collection'
  get 'WGBH' => 'collections#wgbh', :as=> 'wgbh_collection'
  get 'whdh' => 'collections#whdh', :as=> 'whdh_collection'
  get 'WHDH' => 'collections#whdh', :as=> 'whdh_collection'
  get 'wcvb' => 'collections#wcvb', :as=> 'wcvb_collection'
  get 'WCVB' => 'collections#wcvb', :as=> 'wcvb_collection'
  get 'cctv' => 'collections#cctv', :as=> 'cctv_collection'
  get 'CCTV' => 'collections#cctv', :as=> 'cctv_collection'
  
  # I believe the constraint is to allow PID variations in the id.
  resources :catalog, :only => [:index, :show], :constraints => { :id=>/([A-Za-z0-9]|:|-|\.)*([A-Za-z0-9]|:|-){7}/ } do

    # TODO: is this used anywhere
    member do
      get 'cite'
    end
  end

end
