Rails.application.routes.draw do

  get 'welcome/index'

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

  get 'players/auto-complete', to: 'players#auto_complete'

  root 'welcome#index'

  resources :players,
            only: :show,
            param: :username

  resources :games, :events,
            only: :show

  resources :regions, :venues,
            only: :show,
            param: :slug

  namespace :admin do

    resources :players,
              param: :username

    resources :games, :events, :regions, :venues,
              except: :show

    resources :achievements,
              only: [:index, :new, :create]

  end

end
