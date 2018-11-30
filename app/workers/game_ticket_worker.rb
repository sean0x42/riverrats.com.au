# frozen_string_literal: true

# Awards a ticket to a single player from a game
class GameTicketWorker
  include Sidekiq::Worker

  def perform(player_id)
    player = Player.find(player_id)
    player.tickets += 1
    player.save
  end
end
