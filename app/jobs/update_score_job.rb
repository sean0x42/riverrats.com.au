require 'score_lib'

class UpdateScoreJob < ApplicationJob
  include ScoreLib
  queue_as :default


  ###
  # Updates the stats of all players involved in a +game+.
  # @param [Game] game Games to update.
  # @param [Integer] type Whether the game was created or updated.
  def perform (game, type)

    # Update game players
    game.games_players.find_each do |game_player|
      score = calculate_score(game_player.position)

      if type == ObserverType::UPDATE
        update_player(
          game_player.player,
          score - game_player.score,
          game_player.score == 0 ? 1 : 0,
          game_player.score != score and game_player.first_place? ? 1 : 0
        )
      elsif type == ObserverType::CREATE
        update_player(
          game_player.player, score, 1,
          game_player.first_place? ? 1 : 0
        )
      end

      game_player.score = score
      game_player.save
    end

  end


  ###
  # Updates the given +player+ with the given stats.
  # @param [Player] player to update.
  # @param [Integer] score Change in score.
  # @param [Integer] games_played Change in games played.
  # @param [Integer] games_won Change in games won.
  def update_player (player, score, games_played, games_won)
    player.score += score
    player.games_played += games_played
    player.games_won += games_won
    player.save
  end

end
