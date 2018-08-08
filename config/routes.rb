Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 registrations: 'users/registrations'
             }
  root to: 'users#index'
  resources :users, except: %i[create update destroy] do
    resources :pomos
  end
end
