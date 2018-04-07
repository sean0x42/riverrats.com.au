class UpdateVenueJob < ApplicationJob
  queue_as :default


  ###
  # Updates the corresponding venue.
  # @param [Player] player player that was updated.
  # @param [Hash] changes A hash of all changes to to this player
  # @param [Venue] venue to update.
  def perform (player, changes, venue)

    # Get related venue
    venue = PlayersVenues.where(
      venue_id: venue.id,
      player_id: player.id
    ).first_or_create

    venue.score += changes[:score]
    venue.games_played += changes[:plays]
    venue.games_won += changes[:wins]
    venue.save

  end

end
