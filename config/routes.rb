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
  get 'regions/show'
  get 'venues/show'
  get 'games/show'

  resources :players, only: [:show], param: :username

  namespace :admin do
    resources :players, param: :username
    resources :games, except: [:show]
    resources :events, except: [:show]
    resources :regions, except: [:show]
    resources :venues, except: [:show]
  end

end
