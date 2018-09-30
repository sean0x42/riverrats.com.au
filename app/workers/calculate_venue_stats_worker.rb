# frozen_string_literal: true

require 'stats_lib'

# Updates a player's stats at a particular venue
class CalculateVenueStatsWorker
  include Sidekiq::Worker

  def perform(venue, player)
    join = PlayersVenue.includes(:player, :venue)
                       .where(player_id: player, venue_id: venue)
                       .first_or_create
    StatsLib.calc_stats(join, player_id: player, games: { venue_id: venue })
    join.save
  end
end
