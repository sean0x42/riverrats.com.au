# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticated :player do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :players,
             path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' },
             controllers: {
               registrations: 'players/registrations',
               sessions: 'players/sessions',
               passwords: 'players/passwords'
             }

  root 'landing#index'
  get '/privacy-policy', to: 'landing#privacy_policy'
  get '/release-notes', to: 'landing#release_notes'

  resources :players, only: %i[index show], param: :username do
    collection do
      get 'search'
      get 'random'
      get 'auto-complete'
    end
    resources :achievements, only: %i[index show]
  end

  resources :events, only: :show
  resources :games, :seasons, only: %i[index show]
  get '/calendar(/:year/:month)', to: 'events#index', as: 'events'
  resources :regions, :venues, only: :show, param: :slug

  namespace :admin do
    root to: redirect('/admin/players')

    resources :players, except: :show, param: :username
    resources :games, :events, :regions, :venues, except: :show
    resources :achievements, only: %i[new create]

    get 'mail', to: 'mail#index'
    post 'mail/players', to: 'mail#show', defaults: { format: 'csv' }
    get 'scores', to: 'scores#index'
  end
end
