Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 registrations: 'users/registrations'
             }
  root to: 'users#index'
  resources :users, except: %i[new edit update create destroy] do
    resources :pomos
  end
end
