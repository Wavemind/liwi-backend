Rails.application.routes.draw do

  devise_for :users

  root to: 'dashboard#index'

  resources :users, only: [:index, :new, :create, :edit, :update, :delete]

end
