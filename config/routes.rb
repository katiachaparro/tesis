Rails.application.routes.draw do
  #mount ActionCable.server => '/cable'

  # Para el restablecimiento de contraseña desde el login
  devise_for :users, :skip => [:registrations], controllers: {
    registrations: 'registrations',
    passwords: 'passwords'  # Opcional: si quieres personalizar el controlador de contraseñas
  }

  # Para el cambio de contraseña desde el perfil
  as :user do
    get 'users/edit' => 'registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'registrations#update', :as => 'user_registration'
  end

  # Luego tus rutas personalizadas
  resources :users, only: [:update]
  get 'users/profile'
  get 'users/change_password_modal', to: 'users#change_password_modal'

  resources :events, except: [:destroy] do
    resources :victims, except: [:index, :show]
    resources :event_actions, except: [:index, :show]
    resources :resource_requests, except: [:destroy, :show, :edit, :update] do
      get :cancel
    end
    member do
      delete 'sketch/:image_id', to: 'events#destroy_sketch', as: 'destroy_sketch'
      delete 'organization_chart/:image_id', to: 'events#destroy_organization_chart', as: 'destroy_organization_chart'
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