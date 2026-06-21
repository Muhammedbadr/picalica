Rails.application.routes.draw do
  # mount_avo
  # mount_avo
  get "orders/index"
  get "orders/show"
  get "orders/new"
  get "cart_items/create"
  get "cart_items/update"
  get "cart_items/destroy"

  get "carts/index"
  resources :products do
    resources :texts
    resources :lists do
      resources :list_tags
    end
    resources :product_files
    resources :views
    resources :reviews
    resources :images
    resources :licenses
    resources :tags, only: [ :index, :create, :destroy ]
    member do
      get :step_two           # لعرض صفحة الصور والملفات
      patch :update_step_two    # لحفظ بيانات الصفحة الثانية
    end
    collection do
      get :my_product
    end
  end


  resources :roles
  devise_for :users
  resources :orders do
    resources :order_items
  end
  resources :sales, only: [ :index, :show ]
  post "cart/add", to: "cart_items#create", as: :cart_add
  resources :users
  resource :cart, only: [ :show ] do
    get  :pay
    get  :charge
  end
  resources :payments, only: :new

  resources :cart_items, only: [ :create, :destroy ]
   root to: "home#index"
   get "tags/:tag", to: "products#index", as: :tag
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # 2. Keep ONLY this block:
  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end
end
