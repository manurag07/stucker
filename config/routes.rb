# frozen_string_literal: true

Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'connections#create'
  resources :connections, only: [:destroy]
  get '/auth/failure', to: 'connections#omniauth_failure'

  devise_for :users, controllers: { registrations: 'registrations' }
  get 'pages/home'
  root'pages#home'
  get 'dashboard' => 'pages#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
