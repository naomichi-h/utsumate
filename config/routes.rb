Rails.application.routes.draw do
  get 'report', to: 'report#index'
  get 'report/new', to: 'report#new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  resources :logs
  resources :welcome
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
