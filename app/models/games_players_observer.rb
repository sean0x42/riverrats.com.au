require 'score_lib'

class GamesPlayersObserver < ActiveRecord::Observer
  include ScoreLib

  def before_save (game_player)

    if game_player.position_changed?

      changes = { score: 0, plays: 0, wins: 0, second_places: 0, wooden_spoons: 0 }
      player = game_player.player

      # Calculate new score
      game_player.score = calculate_score(game_player.position)

      # Update change in score
      if game_player.score_was == 0
        changes[:score] = game_player.score
        changes[:plays] = 1
      else
        changes[:score] = game_player.score - game_player.score_was
      end

      # Update change in wins
      if game_player.first_place?
        changes[:wins] = 1
      elsif game_player.position_was == 0
        changes[:wins] = -1
      end

      # Update change in second places
      if game_player.position == 1
        changes[:second_places] = 1
      elsif game_player.position_was == 1
        changes[:second_places] = -1
      end

      # Wooden spoons
      if game_player.position == 9
        changes[:wooden_spoons] = 1
      elsif game_player.position_was == 9
        changes[:wooden_spoons] = -1
      end

      # Queue up extended updates
      UpdatePlayerJob.perform_later player, changes
      UpdateVenueJob.perform_later  player, changes, game_player.game.venue
      UpdateRegionJob.perform_later player, changes, game_player.game.venue.region
      UpdateSeasonJob.perform_later player, changes, game_player.game.season

    end

    GameAchievementsJob.perform_later game_player.player

  end


  def before_destroy (game_player)

    changes = { score: (-1 * game_player.score), plays: -1, wins: 0, second_places: 0, wooden_spoons: 0 }
    player = game_player.player

    # These are extracted to reduce line width
    is_first   = (not game_player.position_changed? and game_player.first_place?)
    was_first  =     (game_player.position_changed? and game_player.was_first_place?)

    # Update change in wins
    if is_first || was_first
      changes[:wins] = -1
    end

    # Queue up extended updates
    UpdatePlayerJob.perform_later player, changes
    UpdateVenueJob.perform_later  player, changes, game_player.game.venue
    UpdateRegionJob.perform_later player, changes, game_player.game.venue.region
    UpdateSeasonJob.perform_later player, changes, game_player.game.season

  end

end
