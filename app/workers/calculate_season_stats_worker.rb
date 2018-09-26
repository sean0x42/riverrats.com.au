# frozen_string_literal: true

require 'stats_lib'

# Calculates various statistics for a player within a given season
class CalculateSeasonStatsWorker
  include Sidekiq::Worker

  def perform(season, player)
    join = PlayersSeason.includes(:player, :season)
                        .where(player_id: player, season_id: season)
                        .first_or_create
    StatsLib.calc_stats(join, player_id: player, games: { season_id: season })
    join.save
  end
end
