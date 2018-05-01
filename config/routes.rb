Rails.application.routes.draw do

  require 'sidekiq/web'
  authenticated :player do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :players,
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               sign_up: 'join'
             },
             controllers: {
               registrations: 'players/registrations',
               sessions: 'players/sessions',
               passwords: 'players/passwords'
             }

  root 'welcome#index'

  get 'players/auto-complete', to: 'players#auto_complete'
  get 'players/random', to: 'players#random'

  resources :players,
            only: [:index, :show],
            param: :username

  resources :games, :events,
            only: :show

  resources :regions, :venues,
            only: :show,
            param: :slug

  namespace :admin do

    root to: redirect('/admin/players')

    resources :players,
              except: :show,
              param: :username

    resources :games, :events, :regions, :venues,
              except: :show

    resources :achievements,
              only: [:new, :create]


    get 'mail', to: 'mail#index'
    post 'mail/players', to: 'mail#show'

  end

end
