class UpdatePlayerJob < ApplicationJob
  queue_as :default

  ###
  # Updates the given +player+ with the given stats.
  # @param [Player] player to update.
  # @param [Integer] score Change in score.
  # @param [Integer] games_played Change in games played.
  # @param [Integer] games_won Change in games won.
  def perform (player, score, games_played, games_won)
    player.score += score
    player.games_played += games_played
    player.games_won += games_won
    player.save
  end

end
