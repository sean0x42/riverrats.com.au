# frozen_string_literal: true

# Updates a player's stats at a particular venue
class CalculateVenueStatsWorker
  include Sidekiq::Worker

  def perform(venue, player)
    join = PlayersVenue.includes(:player, :venue)
                       .where(player_id: player, venue_id: venue)
                       .first_or_create
    join.games_played = 0
    join.games_won = 0
    join.score = 0
    GamesPlayer.joins(:game).where(player_id: player, games: { venue_id: venue })
               .find_in_batches do |batch|
      batch.each do |game_player|
        join.games_played += 1
        join.games_won += 1 if game_player.position.zero?
        join.score += game_player.score
      end
    end
    join.save
  end
end
