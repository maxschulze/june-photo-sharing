JunePhotoSharing::Application.routes.draw do
  devise_for :users
  resources :users
  resources :photos do
    collection do
      post :upload
    end
  end
  
  resource :inbox, :controller => 'inbox', :only => [:show, :create]

  root :to => "home#index"
end
