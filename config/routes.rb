Rails.application.routes.draw do
  scope "(:locale)", locale: /en|fr|zh-CN|mg/ do
    devise_for :users
  end

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
        namespace :v1 do
          resources :users, only: %i[index show create update destroy], defaults: { format: "json" } do
            get :me, on: :collection, defaults: { format: "json" }
            get :stats, on: :collection, controller: "users", action: "stats", defaults: { format: "json" }
            patch :me, on: :collection, controller: "users", action: "update_me", defaults: { format: "json" }
            patch :password, on: :member, controller: "users", action: "update_password", defaults: { format: "json" }
            post :roles, on: :member, defaults: { format: "json" }
            delete :roles, on: :member, defaults: { format: "json" }
          end
          resources :companies, defaults: { format: "json" }
          resources :products, only: %i[index show create update destroy], defaults: { format: "json" } do
            patch :status, on: :member, defaults: { format: "json" }
          end
          resources :roles, only: [:index, :show, :create, :update, :destroy], defaults: { format: "json" }
        end
      end
      root "admin#home"
      get "*path", to: "admin#home", constraints: ->(request) { request.format.html? }
    end
  end
end
