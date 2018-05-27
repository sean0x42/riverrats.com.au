class UpdateGlobalRanksJob < ApplicationJob
  queue_as :default

  def perform
    connection = ActiveRecord::Base.connection
    players = Player.all
                .reorder(score: :desc, games_played: :asc, first_name: :asc, last_name: :asc)
                .map.with_index { |player, i| [player.id, i] }.to_h
    players.each { |id, rank| connection.execute "UPDATE players SET rank = #{rank} WHERE id = #{id}" }
  end
end