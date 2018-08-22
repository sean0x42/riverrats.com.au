class UpdateSeasonJob < ApplicationJob
  queue_as :default


  ###
  # Updates the corresponding season.
  # @param [Player] player player that was updated.
  # @param [Hash] changes A hash of all changes to to this player
  # @param [Season] season to update.
  def perform (player, changes, season)

    # Get related season
    season = PlayersSeason.where(
      season_id: season.id,
      player_id: player.id
    ).first_or_create

    season.score += changes[:score]
    season.games_played += changes[:plays]
    season.games_won += changes[:wins]
    season.save

  end

end
