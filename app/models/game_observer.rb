class GameObserver < ActiveRecord::Observer
  def after_create(game)
    UpdateGlobalRanksJob.perform_later
    UpdateSeasonRanksJob.perform_later game.season
  end
end
