class UpdateRegionRanksJob < ApplicationJob
  queue_as :default

  def perform(region)
    connection = ActiveRecord::Base.connection
    players = PlayersRegions.where(region_id: region.id)
                .reorder(score: :desc, games_played: :asc)
                .map.with_index {|player, i| [player.id, i]}.to_h
    players.each {|id, rank| connection.execute "UPDATE players_regions SET rank = #{rank} WHERE id = #{id}"}
  end
end