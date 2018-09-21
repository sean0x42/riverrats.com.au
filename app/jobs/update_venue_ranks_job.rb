class UpdateVenueRanksJob < ApplicationJob
  queue_as :default

  def perform(venue)
    connection = ActiveRecord::Base.connection
    players = PlayersVenue.where(venue_id: venue.id)
                .reorder(score: :desc, games_played: :asc)
                .map.with_index { |player, i| [player.id, i] }.to_h
    players.each { |id, rank| connection.execute "UPDATE players_venues SET rank = #{rank} WHERE id = #{id}" }
  end
end