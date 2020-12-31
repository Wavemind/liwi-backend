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

  resources :technical_files, only: [:index, :create]
  resources :settings, only: [:index]
  resources :languages, only: [:new, :create, :update, :destroy]

  resources :algorithms, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      put 'archive', to: 'algorithms#archive', as: 'archive'
      put 'unarchive', to: 'algorithms#unarchive', as: 'unarchive'
      get 'questions', to: 'algorithms#questions', as: 'question'
      get 'drugs', to: 'algorithms#drugs', as: 'drug'
      get 'drug_exclusions', to: 'algorithms#drug_exclusions', as: 'drug_exclusions'
      get 'management_exclusions', to: 'algorithms#management_exclusions', as: 'management_exclusions'
      get 'managements', to: 'algorithms#managements', as: 'management'
      get 'questions_sequences', to: 'algorithms#questions_sequences', as: 'questions_sequence'
      get 'questions_sequences_scored', to: 'algorithms#questions_sequences_scored', as: 'questions_sequence_scored'
      put 'import_villages'
    end

    resources :versions, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        get 'final_diagnoses_exclusions', to: 'versions#final_diagnoses_exclusions', as: 'final_diagnoses_exclusions'
        get 'generate_translations'
        get 'generate_variables'
        get 'final_diagnostics', to: 'versions#final_diagnostics', as: 'final_diagnostic'
        put 'archive', to: 'versions#archive', as: 'archive'
        put 'unarchive', to: 'versions#unarchive', as: 'unarchive'
        post 'duplicate'
        post 'components'
        delete 'remove_components'
        put 'change_triage_order'
        put 'change_systems_order'
        put 'create_triage_condition'
        put 'remove_triage_condition'
        put 'regenerate_json'
        put 'update_list'
        put 'import_translations'
      end

      resources :final_diagnostics do
        collection do
          post 'add_exclusion'
          delete 'remove_exclusion'
        end
      end

      resources :diagnostics, only: [:index, :new, :create, :edit, :update, :show, :destroy, :duplicate] do
        member do
          post 'duplicate'
          get 'diagram'
          get 'validate'
        end

        resources :final_diagnostics, only: [:index, :new, :create, :edit, :update, :delete, :destroy] do
          member do
            get 'diagram'
          end
          resources :final_diagnostic_health_cares, only: [:create, :destroy]
        end
      end
    end

    resources :questions, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        post 'validate'
        get 'lists'
      end

      resources :answers, only: [] do
      end
    end

    resources :managements, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        post 'create_exclusion'
        delete 'remove_exclusion'
      end
    end

    resources :drugs, only: [:new, :create, :edit, :update, :destroy] do
      collection do
        post 'validate'
        post 'create_exclusion'
        delete 'remove_exclusion'
      end
    end

    resources :questions_sequences, only: [:index, :new, :create, :edit, :update, :destroy] do
      collection do
        get 'lists'
      end
    end
  end

  resources :questions_sequences, only: [] do
    resources :instances, only: [:destroy, :create] do
      collection do
        get 'by_reference'
        put 'update_score'
      end
      member do
        delete 'remove_link'
        post 'create_link'
      end
      resources :conditions, only: [:destroy]
    end

    collection do
      get 'reference_prefix'
    end

    member do
      get 'diagram'
      get 'validate'
    end
  end

  resources :instances, only: [:update]

  resources :diagnostics, only: [] do
    resources :instances, only: [:show, :destroy, :create] do
      collection do
        get 'by_reference'
        get 'load_conditions'
      end
      member do
        delete 'remove_link'
        post 'create_link'
      end
      resources :conditions, only: [:destroy]
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

  resources :health_facilities, only: [:index, :show, :new, :create, :edit, :update] do
    delete 'devices/:device_id/remove_device', to: 'health_facilities#remove_device', as: 'remove_device'
    post 'add_device', to: 'health_facilities#add_device', as: 'add_device'
    get 'sticker_form', to: 'health_facilities#sticker_form', as: 'sticker_form'
    post 'generate_stickers', to: 'health_facilities#generate_stickers', as: 'generate_stickers'
  end

  resources :health_facility_accesses, only: [:index, :create]

  resources :devices, only: [:index, :show, :new, :create]

  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      post ':id/activated', to: 'users#activated', as: 'activated'
      post ':id/deactivated', to: 'users#deactivated', as: 'deactivated'
    end
  end

  resources :questions, only: [] do
    collection do
      get 'reference_prefix'
    end
  end

  resources :drugs, only: [] do
    collection do
      get 'lists'
    end
  end

  resources :answers, only: [] do
    collection do
      get 'operators'
    end
  end


  require "sidekiq/web"
  mount Sidekiq::Web => '/sidekiq'

  # API
  namespace :api do
    namespace :v1 do
      resources :versions, only: [:show] do
        get 'json_test', to: 'versions#json_test'
        collection do
          post 'retrieve_algorithm_version', to: 'versions#retrieve_algorithm_version'
          get 'json_from_facility', to: 'versions#json_from_facility'
          get 'facility_attributes', to: 'versions#facility_attributes'
        end
      end
      resources :devices, only: [:show]
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :devices, only: [:create]

      get 'is_available', to: 'application#is_available'
      get 'categories', to: 'application#categories'
    end
  end
end
