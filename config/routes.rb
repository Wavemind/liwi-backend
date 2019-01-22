Rails.application.routes.draw do

  # Web
  devise_for :users

  root to: 'dashboard#index'

  resources :roles, only: [:index, :show, :new, :create, :edit, :update]

  resources :algorithms, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      put 'archive', to: 'algorithms#archive', as: 'archive'
      put 'unarchive', to: 'algorithms#unarchive', as: 'unarchive'
    end

    resources :algorithm_versions, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        put 'archive', to: 'algorithm_versions#archive', as: 'archive'
        put 'unarchive', to: 'algorithm_versions#unarchive', as: 'unarchive'
      end
    end
  end

  resources :groups, only: [:index, :show, :new, :create, :edit, :update] do
    delete 'users/:user_id/remove_user', to: 'groups#remove_user', as: 'remove_user'
    post 'add_user', to: 'groups#add_user', as: 'add_user'
  end

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
