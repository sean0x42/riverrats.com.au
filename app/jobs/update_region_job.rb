class UpdateRegionJob < ApplicationJob
  queue_as :default

  ###
  # Updates the corresponding region.
  # @param [Player] player player that was updated.
  # @param [Hash] changes A hash of all changes to to this player
  # @param [Region] region to update.
  def perform (player, changes, region)

    # Get related region
    region = PlayersRegions.where(
      region_id: region.id,
      player_id: player.id
    ).first_or_create

    region.score += changes[:score]
    region.games_played += changes[:plays]
    region.games_won += changes[:wins]
    region.second_places += changes[:second_places]
    region.wooden_spoons += changes[:wooden_spoons]
    region.save

  end

end
