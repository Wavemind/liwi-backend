Rails.application.routes.draw do

  # Web
  devise_for :users

  root to: 'dashboard#index'

  resources :roles, only: [:index, :show, :new, :create, :edit, :update]
  resources :groups, only: [:index, :show, :new, :create, :edit, :update]
  resources :devices, only: [:index, :show] do
    collection do
      get 'map'
    end
  end
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      post ':id/activated', to: 'users#activated', as: 'activated'
      post ':id/deactivated', to: 'users#deactivated', as: 'deactivated'
    end
  end

  # API
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :activities, only: [:create]
    end
  end

end
