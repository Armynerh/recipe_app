# config/routes.rb

Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "recipes#index"

  resources :foods, except: [:update]
  get '/general_shopping_list', to: 'general_shopping_list#index'
  resources :public_recipes, only: [:index]
  resources :recipes, except: [:update] do
    resources :recipe_foods, only: [:new, :create, :destroy]
    member do
      post 'toggle_public'
    end
  end
end
