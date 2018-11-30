Rails.application.routes.draw do

  devise_for :users

  root to: 'dashboard#index'
  resources :roles, only: [:index, :show, :new, :create, :edit, :update]
  resources :groups, only: [:index, :show, :new, :create, :edit, :update]
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      post ':id/activated', to: 'users#activated', as: 'activated'
      post ':id/deactivated', to: 'users#deactivated', as: 'deactivated'
    end
  end

end
