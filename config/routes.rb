Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords'
  }

  resources :comments

  root 'comments#index'
end
