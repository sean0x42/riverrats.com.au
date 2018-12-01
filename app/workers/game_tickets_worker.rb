# frozen_string_literal: true

# A worker which awards the given number of tickets to players in a game
class GameTicketsWorker
  include Sidekiq::Worker

  def perform(game_id, tickets)
    game = Game.find(game_id)
    game.game_played_by.limit(tickets).pluck(:id).each do |id|
      GameTicketWorker.perform_async(id)
    end
  end
end
