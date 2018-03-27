Rails.application.routes.draw do
  devise_for :players
  root to: 'events#index'
  get 'events/index'
  get 'events/show'
  get 'regions/show'
  get 'venues/show'
  get 'games/show'
  get 'players/show'
end
