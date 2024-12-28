Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  constraints(subdomain: "me") do
    scope module: "me", as: :me do
      root "me#home"
    end
  end

  # Defines the root path route ("/")
  constraints(subdomain: "admin") do
    scope module: "admin", as: :admin do
      namespace :api do
        resources :users, only: %i[index], defaults: { format: "json" } do
          get :me, on: :collection, defaults: { format: "json" }
        end
      end
      root "admin#home"
      get "*path", to: "admin#home", constraints: ->(request) { request.format.html? }
    end
  end
end
