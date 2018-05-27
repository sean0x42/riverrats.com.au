class UpdateSeasonRanksJob < ApplicationJob
  queue_as :default

  def perform(season)
    connection = ActiveRecord::Base.connection
    players = PlayersSeasons.where(season_id: season.id)
                .reorder(score: :desc, games_played: :asc)
                .map.with_index { |player, i| [player.id, i] }.to_h
    players.each { |id, rank| connection.execute "UPDATE players_seasons SET rank = #{rank} WHERE id = #{id}" }
  end
end