Rails.application.routes.draw do
  devise_for :users, path: "admin", skip: [ :registrations ]

  namespace :admin do
    devise_scope :user do
      get "profile/edit", to: "users/registrations#edit", as: :edit_registration
      patch "profile", to: "users/registrations#update", as: :update_registration
      put "profile", to: "users/registrations#update"
      delete "profile", to: "users/registrations#destroy"
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
