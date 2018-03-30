Rails.application.routes.draw do

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

  resources :games, only: :show
  resources :players,
            only: :show,
            param: :username
  resources :regions, :venues,
            only: :show,
            param: :slug

  namespace :admin do
    resources :players, param: :username
    resources :games, :events,
              except: :show
    resources :regions, :venues,
              except: :show,
              param: :slug
  end

end
