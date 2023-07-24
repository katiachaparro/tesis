Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
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

  resources :assist_requests, only: [] do
    collection do
      post :create_assist
    end
    get :arrive_modal
    put :arrive
    get :demobilize_modal
    put :demobilize
    get :state_modal
    put :change_state
  end
  resources :user_permissions, :except => [:destroy, :show]
  resources :resources, :except => [:destroy, :show] do
    collection do
      get :search_resources
    end
  end

  resources :organizations, :except => [:destroy] do
    resources :resource_per_organizations, :except => [:destroy, :show]
  end
  resources :users, only: [:update]
  get 'users/profile'
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end
  resources :notifications, only: [:index, :show] do
    collection do
      get :mark_as_read
    end
  end
  get 'reports/report'
  root to: 'dashboard#index'
  get 'dashboard/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
