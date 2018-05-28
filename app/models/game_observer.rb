class GameObserver < ActiveRecord::Observer

  def after_create (game)
    UpdateGlobalRanksJob.perform_later
    UpdateSeasonRanksJob.perform_later game.season
    UpdateVenueRanksJob.perform_later game.venue
    UpdateRegionRanksJob.perform_later game.venue.region
  end

end
