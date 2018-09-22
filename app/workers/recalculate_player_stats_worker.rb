# frozen_string_literal: true

# Recalculates a players statistics. This is time consuming but guaranteed to be
# accurate.
class RecalculatePlayerStatsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(player_id)
    player = Player.includes(:games_players).find(player_id)
    return if player.nil?

    score = played = won = 0

    # Calculate new ones
    player.games_players.each do |game|
      score += game.score
      played += 1
      won += 1 if game.position.zero?
    end

    player.update(score: score, games_played: played, games_won: won)
  end
end
