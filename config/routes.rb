Rails.application.routes.draw do
  get "thrift_items/new"
  get "thrift_items/create"
  get "thrift_items/index"
  devise_for :users
  get "navbar/index"
  get "landing_page/index"
  
  # user page
  get '/account', to: 'users#account', as: 'account'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "landing_page#index"
  get 'catalog', to: 'clothings#catalog', as: 'catalog' # routes to "catalog.html" instead of index
    # index instead is used to display one top and one bottom
  resources :clothings # generates full set of restful routes for clothings

  resources :clothings do
    member do
      get 'confirm_destroy'
      get 'update'
    end
  end

  resources :outfits do
    member do
      get 'confirm_destroy'
    end

    resources :outfit_items, only: [:create, :destroy]  # Create and destroy actions
  end

  resources :outfit_items, only: [:create, :destroy]
  
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  resources :thrift_items, only: [:index, :new, :create]


end