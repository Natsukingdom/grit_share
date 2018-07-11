Rails.application.routes.draw do
  root 'pomos#new'
  resources :users
  resources :pomos
end
