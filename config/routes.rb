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

  resources :settings, only: [:index]
  resources :languages, only: [:new, :create, :update, :destroy]

  resources :algorithms, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      put 'archive', to: 'algorithms#archive', as: 'archive'
      put 'unarchive', to: 'algorithms#unarchive', as: 'unarchive'
      get 'questions', to: 'algorithms#questions', as: 'question'
      get 'treatments', to: 'algorithms#treatments', as: 'treatment'
      get 'managements', to: 'algorithms#managements', as: 'management'
      get 'predefined_syndromes', to: 'algorithms#predefined_syndromes', as: 'predefined_syndrome'
    end

    resources :versions, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        put 'archive', to: 'versions#archive', as: 'archive'
        put 'unarchive', to: 'versions#unarchive', as: 'unarchive'
      end

      resources :diagnostics, only: [:index, :new, :create, :edit, :update, :show, :destroy, :duplicate, :update_translations] do
        member do
          put 'update_translations'
          post 'duplicate'
          get 'diagram'
        end

        resources :final_diagnostics, only: [:index, :show, :new, :create, :edit, :update, :delete, :destroy, :update_translations] do
          member do
            post 'add_excluded_diagnostic'
            delete 'remove_excluded_diagnostic'
            put 'update_translations'
          end
          resources :final_diagnostic_health_cares, only: [:create, :destroy]
        end
      end
    end

    resources :questions, only: [:new, :create, :edit, :update, :destroy] do
      member do
        put 'answers'
        put 'update_translations'
      end

      resources :answers, only: [:new, :create, :edit, :update] do
        member do
          put 'update_translations'
        end
      end
    end

    resources :treatments, only: [:new, :create, :edit, :update, :destroy] do
      member do
        put 'update_translations'
      end
    end

    resources :managements, only: [:new, :create, :edit, :update, :destroy] do
      member do
        put 'update_translations'
      end
    end

    resources :predefined_syndromes, only: [:index, :new, :create, :edit, :update, :destroy] do
      member do
        put 'update_translations'
      end
    end
  end

  resources :predefined_syndromes, only: [:show] do
    resources :instances, only: [:show, :destroy, :create, :by_reference] do
      collection do
        get 'by_reference'
      end
      resources :children, only: [:create, :destroy]
      resources :conditions, only: [:create, :destroy]
    end
  end

  resources :diagnostics, only: [] do
    resources :instances, only: [:show, :destroy, :create, :by_reference] do
      collection do
        get 'by_reference'
      end
      resources :children, only: [:create, :destroy]
      resources :conditions, only: [:create, :destroy]
    end
    resources :conditions, only: [] do

      collection do
        post 'differential', to: 'conditions#add_diagnostic_condition'
      end

      member do
        delete 'differential', to: 'conditions#destroy_diagnostic_condition'
      end
    end
  end

  get 'instanceable/:type/:id', to: 'instances#index', as: 'instanceable'

  resources :groups, only: [:index, :show, :new, :create, :edit, :update] do
    delete 'devices/:device_id/remove_device', to: 'groups#remove_device', as: 'remove_device'
    post 'add_device', to: 'groups#add_device', as: 'add_device'
  end

  resources :group_accesses, only: [:index, :create]

  resources :devices, only: [:index, :show, :new, :create] do
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
      resources :versions, only: [:index]
    end
  end
end
