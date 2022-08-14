Rails.application.routes.draw do
  get 'top', to: 'top#index'
  get 'report', to: 'report#index'
  get 'report/new', to: 'report#new'
  get 'report/create', to: 'report#show'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  resources :logs
  resources :users

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
