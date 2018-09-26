# frozen_string_literal: true

# Recalculates a players statistics. This is time consuming but guaranteed to be
# accurate.
class CalculatePlayerStatsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(player_id)
    player = Player.includes(:games_players).find(player_id)
    return if player.nil?

    reset(player)
    player.games_players.each do |game_player|
      player.score += game_player.score
      player.games_played += 1
      player.games_won += 1 if game_player.position.zero?
      player.second_places += 1 if game_player.position == 1
      player.wooden_spoons += 1 if game_player.last?
    end

    player.save
  end

  def reset(player)
    player.score = 0
    player.games_played = 0
    player.games_won = 0
    player.second_places = 0
    player.wooden_spoons = 0
  end
end
