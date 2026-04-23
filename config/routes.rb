Rails.application.routes.draw do
 
  resources :users
 
  resources :products do
    resources :texts
    resources :lists do
      resources :list_tags
    end
    resources :product_files
    resources :views
    resources :images
    resources :payments
    resources :licenses
    resources :tags, only: [:index, :create, :destroy]

  end
  # resources :users do 
  #   resources :profiles
  # end 
  resources :roles
  devise_for :users, controllers: {
        # sessions: 'users/sessions'
    }

  
   root to: "home#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
