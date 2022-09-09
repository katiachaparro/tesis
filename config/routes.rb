Rails.application.routes.draw do
  resources :events
  resources :event_actions, only: [], param: :index do
    member do
      delete '(:id)' => "event_actions#destroy", as: ""
      post '/' => "event_actions#create"
    end
  end
  resources :user_permissions, :except => [:destroy, :show]
  resources :resources, :except => [:destroy, :show]
  resources :organizations, :except => [:destroy, :show] do
    resources :resource_per_organizations, :except => [:destroy, :show]
  end
  resources :users, only: [:update]
  get "users/profile"
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  root to: "dashboard#index"
  get "dashboard/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
