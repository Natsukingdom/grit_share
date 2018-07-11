Rails.application.routes.draw do
  resources :users
  resources :pomos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'pomo', to: 'pomo#new'
  get 'pomo/list'
end
