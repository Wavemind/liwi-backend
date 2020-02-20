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

  resources :technical_files, only: [:index, :new, :create]
  resources :settings, only: [:index]
  resources :languages, only: [:new, :create, :update, :destroy]

  resources :algorithms, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      put 'archive', to: 'algorithms#archive', as: 'archive'
      put 'unarchive', to: 'algorithms#unarchive', as: 'unarchive'
      get 'questions', to: 'algorithms#questions', as: 'question'
      get 'treatments', to: 'algorithms#treatments', as: 'treatment'
      get 'managements', to: 'algorithms#managements', as: 'management'
      get 'questions_sequences', to: 'algorithms#questions_sequences', as: 'questions_sequence'
      get 'questions_sequences_scored', to: 'algorithms#questions_sequences_scored', as: 'questions_sequence_scored'
    end

    resources :versions, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        put 'archive', to: 'versions#archive', as: 'archive'
        put 'unarchive', to: 'versions#unarchive', as: 'unarchive'
        post 'duplicate'
        put 'change_triage_order'
        put 'create_triage_condition'
        put 'remove_triage_condition'
      end

      resources :diagnostics, only: [:index, :new, :create, :edit, :update, :show, :destroy, :duplicate, :update_translations] do
        member do
          put 'update_translations'
          post 'duplicate'
          get 'diagram'
          get 'validate'
        end

        resources :final_diagnostics, only: [:index, :new, :create, :edit, :update, :delete, :destroy, :update_translations] do
          collection do
            post 'create_from_diagram'
            put 'add_excluded_diagnostic'
          end
          member do
            put 'remove_excluded_diagnostic'
            put 'update_translations'
            put 'update_from_diagram'
            get 'diagram'
          end
          resources :final_diagnostic_health_cares, only: [:create, :destroy]
        end
      end
    end

    resources :questions, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        post 'create_from_diagram'
        post 'validate'
      end
      member do
        put 'answers'
        put 'update_from_diagram'
        put 'update_translations'
      end

      resources :answers, only: [:new, :create, :edit, :update] do
        member do
          put 'update_translations'
        end
      end
    end

    resources :managements, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        post 'create_from_diagram'
      end
      member do
        put 'update_from_diagram'
        put 'update_translations'
      end
    end

    resources :treatments, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        post 'create_from_diagram'
      end
      member do
        put 'update_from_diagram'
        put 'update_translations'
      end
    end

    resources :questions_sequences, only: [:index, :new, :create, :edit, :update, :destroy, :new_scored, :edit_scored] do
      collection do
        get 'new_scored'
        post 'create_from_diagram'
      end
      member do
        get 'edit_scored'
        put 'update_from_diagram'
        put 'update_translations'
      end
    end
  end

  resources :questions_sequences, only: [] do
    resources :instances, only: [:show, :destroy, :create, :by_reference] do
      collection do
        get 'by_reference'
        post 'create_from_diagram'
        post 'create_link'
        delete 'remove_from_diagram'
        delete 'remove_link'
        put 'update_score'
      end
      resources :children, only: [:create, :destroy]
      resources :conditions, only: [:create, :destroy]

    end
    collection do
      get 'reference_prefix'
    end
    member do
      get 'diagram'
      get 'validate'
    end
  end

  resources :diagnostics, only: [] do
    resources :instances, only: [:show, :destroy, :create, :by_reference] do
      collection do
        get 'by_reference'
        get 'load_conditions'
        post 'create_from_diagram'
        post 'create_from_final_diagnostic_diagram'
        post 'create_link'
        delete 'remove_from_diagram'
        delete 'remove_link'
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

  resources :questions, only: [:reference_prefix] do
    collection do
      get 'reference_prefix'
    end
  end

  # API
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :activities, only: [:create]
      resources :versions, only: [:index]

      get 'is_available', to: 'application#is_available'
    end
  end
end
