Rails.application.routes.draw do

  require 'sidekiq/web'
  authenticated :player do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :players,
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'register'
             },
             controllers: {
               registrations: 'players/registrations',
               sessions: 'players/sessions'
             }

  root to: 'events#index'
  get 'events/show'
  get 'players/auto-complete', to: 'players#auto_complete'

  resources :players,
            only: :show,
            param: :username
  resources :games, :venues, only: :show
  resources :regions, only: :show, param: :slug

  namespace :admin do
    resources :players, param: :username
    resources :games, :events, :regions, :venues,
              except: :show
  end

end
