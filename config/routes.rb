Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'users/registrations'
  }
  root to: 'users#index'
  resources :users
  resources :pomos
end
