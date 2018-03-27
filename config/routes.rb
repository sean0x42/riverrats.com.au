Rails.application.routes.draw do
  get 'events/index'

  get 'events/show'

  get 'regions/show'

  get 'venues/show'

  get 'games/show'
  get 'players/show'
end
