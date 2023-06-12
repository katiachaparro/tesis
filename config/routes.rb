Rails.application.routes.draw do
  resources :events, except: [:destroy] do
    resources :victims, except: [:index, :show]
    resources :event_actions, except: [:index, :show]
    resources :resource_requests, except: [:destroy, :show, :edit, :update] do
      get :cancel
    end
    get :export_201
    get :export_207
    get :export_211
    get :close_event_modal
    post :close_event
  end
  resources :resource_requests, only: [:index, :new, :create] do
    resources :assist_requests, only: [:new, :create]
  end
  post 'assist_requests/create_assist'
  resources :assist_requests, only: [] do
    get :arrive_modal
    put :arrive
    get :demobilize_modal
    put :demobilize
    get :state_modal
    put :change_state
  end
  resources :user_permissions, :except => [:destroy, :show]
  resources :resources, :except => [:destroy, :show]
  get 'resources/search_resources'
  resources :organizations, :except => [:destroy, :show] do
    resources :resource_per_organizations, :except => [:destroy, :show]
  end
  resources :users, only: [:update]
  get 'users/profile'
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  root to: 'dashboard#index'
  get 'dashboard/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
