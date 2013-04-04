JunePhotoSharing::Application.routes.draw do
  devise_for :users
  resources :users
  resources :photos do
    collection do
      post :upload
    end
  end
  
  match 'upload_from_email' => "photos#upload_from_email"

  root :to => "home#index"
end
