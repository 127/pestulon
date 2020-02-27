# frozen_string_literal: true

# Docs
Rails.application.routes.draw do
  # devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'omniauth_callbacks'}

  namespace :admin do
    root to: 'users#index'
    resources :subscriptions, :users, :accounts, :roles
  end

  scope '(:locale)', locale: /en|ru/ do

    root to: 'pages#index'
    get 'pages/*page' => 'pages#index', :as => 'pages'

    resources :subscriptions, only: [:show, :new, :create]

    resources :account, only: [:index] do
      delete 'user/:id(.:format)', to: 'account#remove'
    end

    devise_for :users,
               controllers: {
                 registrations: 'registrations',
                 invitations: 'invitations' },
               path: 'auth',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 password: 'secret',
                 confirmation: 'verification',
                 unlock: 'unblock',
                 registration: 'register',
                 sign_up: 'cmon_let_me_in'
               }
    # ,
    #            skip: :omniauth_callbacks

  end
end
