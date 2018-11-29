Rails.application.routes.draw do

  devise_for :users

  root to: 'dashboard#index'

  resources :users, only: [:index, :show, :new, :create, :edit, :update]
  resources :roles, only: [:index, :show, :new, :create, :edit, :update]

end
