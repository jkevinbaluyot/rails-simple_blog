Rails.application.routes.draw do
  resources :web_settings, only: %i[edit update]
  resources :authors, except: [:show]
  resources :categories, except: [:show]
  resources :tags, except: [:show]
  resources :articles
  devise_for :users,
    path: "admin",
    controllers: {
      sessions: "admin/users/sessions",
      passwords: "admin/users/passwords",
      confirmations: "admin/users/confirmations",
      unlocks: "admin/users/unlocks",
      registrations: "admin/users/registrations"
    }

  namespace :admin do
    devise_scope :user do
      get "profile/edit", to: "users/registrations#edit", as: :edit_registration
      patch "profile", to: "users/registrations#update", as: :update_registration
      put "profile", to: "users/registrations#update"
      delete "profile", to: "users/registrations#destroy"

      patch "profile/two_factor", to: "two_factor#update", as: :update_user_two_factor
      delete "profile/two_factor", to: "two_factor#destroy", as: :disable_user_two_factor
      post "profile/regenerate_backup_codes", to: "two_factor#regenerate_backup_codes", as: :regenerate_user_backup_codes
      post "profile/two_factor/enable", to: "two_factor#create", as: :enable_two_factor
      delete "profile/two_factor/disable", to: "two_factor#destroy", as: :disable_two_factor

      get "two_factor", to: "users/sessions#two_factor", as: :two_factor
      post "two_factor/verify", to: "users/sessions#two_factor_verify", as: :two_factor_verify
    end
  end



  namespace :admin do
    root "home#index"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "home" => "home#index", as: :home
  root "home#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
