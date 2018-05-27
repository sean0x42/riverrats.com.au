class GameObserver < ActiveRecord::Observer

  def after_create (game)
    UpdateGlobalRanksJob.perform_later
    UpdateSeasonRanksJob.perform_later game.season
    UpdateVenueRanksJob.perform_later game.venue
  end

  def after_update (game)
    UpdateGlobalRanksJob.perform_later
    UpdateSeasonRanksJob.perform_later game.season
    UpdateVenueRanksJob.perform_later game.venue
  end

end
