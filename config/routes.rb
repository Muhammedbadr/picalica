Rails.application.routes.draw do
  resources :products do
    # resources :categories
    resources :texts
    resources :lists do
      resources :list_tags
    end
    resources :product_files
    resources :views
    resources :images
    resources :payments
    resources :licenses
    resources :tags, only: [ :index, :create, :destroy ]
    member do
      get :step_two           # لعرض صفحة الصور والملفات
      patch :update_step_two    # لحفظ بيانات الصفحة الثانية
    end
  end
  # resources :users do
  #   resources :profiles
  # end
  resources :roles
  devise_for :users, controllers: {
      # sessions: 'users/sessions'
    }

  resources :users

   root to: "home#index"
   get "tags/:tag", to: "products#index", as: :tag
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
