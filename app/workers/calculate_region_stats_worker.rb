# frozen_string_literal: true

require 'stats_lib'

# A worker for calculating region stats
class CalculateRegionStatsWorker
  include Sidekiq::Worker

  def perform(region, player)
    join = PlayersRegion.includes(:player, :region)
                        .where(player_id: player, region_id: region)
                        .first_or_create
    venues = Venue.where(region_id: region).pluck(:id)
    StatsLib.calc_stats(join, player_id: player, games: { venue_id: venues })
    join.save
  end
end
