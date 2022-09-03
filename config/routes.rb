Rails.application.routes.draw do
  resources :resources, :except => [:destroy, :show]
  resources :organizations, :except => [:destroy, :show] do
    resources :resource_per_organizations, :except => [:destroy, :show]
  end
  resources :users, only: [:update]
  get "users/profile"
  devise_for :users
  root to: "dashboard#index"
  get "dashboard/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
