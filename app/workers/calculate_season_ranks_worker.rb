# frozen_string_literal: true

# Calculates the ranks of all players within a particular season
class CalculateSeasonRanksWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'low_priority'

  SQL = 'players_seasons.id, rank() OVER (ORDER BY players_seasons.score DESC, players.username ASC) AS rank'

  def perform(season_id)
    players = PlayersSeason.joins(:player)
                           .where(season_id: season_id)
                           .select(SQL)

    players.each do |player|
      PlayersSeason.find(player.id).update(rank: player.rank - 1)
    end
  end
end
