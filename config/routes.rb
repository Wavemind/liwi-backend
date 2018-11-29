Rails.application.routes.draw do

  root to: 'dashboard#index'

  resources :users, only: [:index, :new, :create, :edit, :update, :delete]
end
