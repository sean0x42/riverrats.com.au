class UpdateSeasonJob < ApplicationJob
  queue_as :default

  ###
  # Updates the corresponding season.
  # @param [Game] game that occurred in this season
  def perform (game)

    season = game.season

    # Iterate over players
    game.games_players.find_each do |game_player|
      player = game_player.player
      player_season = PlayersSeasons.where(season_id: season.id, player_id: player.id)

      if player_season.exists?
        # Update existing season
        player_season.score += game_player.score
        player_season.games_played += 1
        if game_player.first_place?
          player_season.games_won += 1
        end
      else
        # Create a new player season join
        PlayersSeasons.create(
          season_id: season.id,
          player_id: player.id,
          score: game_player.score,
          games_played: 1,
          games_won: game_player.first_place? ? 1 : 0
        )
      end

    end

  end

  ###
  # Creates a new season
  def create_season (season_id, player_id, score, games_played, games_won)

  end

end
