Rails.application.routes.draw do

  # Web
  devise_for :users

  authenticated :user do
    root to: 'dashboard#index'
  end
  unauthenticated :user do
    devise_scope :user do
      get '/' => 'devise/sessions#new'
    end
  end

  resources :roles, only: [:index, :show, :new, :create, :edit, :update]

  resources :algorithms, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      put 'archive', to: 'algorithms#archive', as: 'archive'
      put 'unarchive', to: 'algorithms#unarchive', as: 'unarchive'
      get 'questions', to: 'algorithms#questions', as: 'question'
      get 'treatments', to: 'algorithms#treatments', as: 'treatment'
      get 'managements', to: 'algorithms#managements', as: 'management'
      get 'predefined_syndromes', to: 'algorithms#predefined_syndromes', as: 'predefined_syndrome'
    end

    resources :algorithm_versions, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        put 'archive', to: 'algorithm_versions#archive', as: 'archive'
        put 'unarchive', to: 'algorithm_versions#unarchive', as: 'unarchive'
      end
      resources :diagnostics, only: [:index, :new, :create, :edit, :update]
    end

    resources :questions, only: [:new, :create, :edit, :update] do
      member do
        put 'answers'
      end

      resources :answers, only: [:new, :create, :edit, :update]
    end

    resources :treatments, only: [:new, :create, :edit, :update]
    resources :managements, only: [:new, :create, :edit, :update]

    resources :predefined_syndromes, only: [:index, :new, :create, :edit, :update]
  end

  resources :predefined_syndromes, only: [:show] do
    resources :relations, only: [:show, :destroy, :create] do
      resources :children, only: [:create, :destroy]
      resources :conditions, only: [:create, :destroy]
    end
  end

  resources :diagnostics, only: [:show] do
    resources :relations, only: [:show, :destroy, :create] do
      resources :children, only: [:create, :destroy]
      resources :conditions, only: [:create, :destroy]
    end
  end

  get 'relationable/:type/:id', to: 'relations#index', as: 'relationable'

  resources :groups, only: [:index, :show, :new, :create, :edit, :update] do
    delete 'devices/:device_id/remove_device', to: 'groups#remove_device', as: 'remove_device'
    post 'add_device', to: 'groups#add_device', as: 'add_device'
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

  resources :categories, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get 'reference'
    end
  end

  # API
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :activities, only: [:create]
      resources :algorithm_versions, only: [:index]
    end
  end
end
