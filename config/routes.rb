# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :user_roles
    resources :o_auths
    resources :abilities
    resources :roles

    root to: 'users#index'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Comment out before initializing
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # user root
  get 'users', action: :show, controller: :users, as: :user_root
  root 'welcome#index'

  # about recipes
  resource :ingredients
end
