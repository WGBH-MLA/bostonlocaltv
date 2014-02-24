Bostonlocaltv::Application.routes.draw do

  resources :collections

  Blacklight.add_routes(self)

  root :to => "catalog#home"

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  match 'catalog/citation', :as => "citation_catalog"
 
  match 'wgbh' => 'collections#wgbh', :as=> 'wgbh_collection'
  match 'WHDH' => 'collections#whdh', :as=> 'whdh_collection'
  match 'wcvb' => 'collections#wcvb', :as=> 'wcvb_collection'
  match 'CCTV' => 'collections#cctv', :as=> 'cctv_collection'
  
  # I believe the constraint is to allow PID variations in the id.
  resources :catalog, :only => [:index, :show, :update], :constraints => { :id=>/([A-Za-z0-9]|:|-|\.)*([A-Za-z0-9]|:|-){7}/ } do

    # TODO: is this used anywhere
    member do
      get 'cite'
    end
  end


  get 'dashboard', to: 'users#show'

end
