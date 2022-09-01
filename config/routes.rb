Rails.application.routes.draw do
  get 'top', to: 'top#index'
  get 'report', to: 'report#index'
  get 'report/new', to: 'report#new'
  get 'terms_of_service', to: 'top#terms_of_service'
  get 'privacy_policy', to: 'top#privacy_policy'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  resources :logs
  resources :users, only: %i(update)

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
