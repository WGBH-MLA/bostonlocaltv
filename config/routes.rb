Bostonlocaltv::Application.routes.draw do

  resources :collections

  Blacklight.add_routes(self)

  root :to => "catalog#home"

  devise_for :users
  ActiveAdmin.routes(self)


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
  resources :catalog, :only => [:index, :show, :update], :constraints => { :id=>/([A-Za-z0-9]|:|-|\.)*([A-Za-z0-9]|:|-){7}/ } do

    # TODO: is this used anywhere
    member do
      get 'cite'
    end
  end

  match 'styleguide' => 'styleguide#index'
  
  resources :comments, :only => [:create]
  resources :digitizations
  resources :sponsorships do
    member do
      put 'confirm'
      put 'unconfirm'
    end
  end
  
  get 'dashboard', to: 'users#show'

end
