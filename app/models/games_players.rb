require 'score_lib'

class GamesPlayers < ApplicationRecord
  include ScoreLib
  include ActiveModel::Dirty

  belongs_to :game
  belongs_to :player

  default_scope { order(:position) }

  validates :game, :player,
            presence: true

  validates :position, :score,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  before_save :update_stats
  before_destroy :destroy_stats


  ###
  # Returns whether this player is in first place.
  # @return [Boolean] Whether the player is in first.
  def first_place?
    position == 0
  end


  ###
  # Updates the game players stats before save, and queues
  # an update for the associated player.
  def update_stats

    if position_changed?

      # Init. Note that delta here denotes a change. I.e.
      # delta_score is the change in score.
      delta_plays, delta_wins = 0

      # Calculate new score
      self.score = calculate_score(position)

      # Update delta_score
      if score_was == 0
        delta_score = score
        delta_plays = 1
      else
        delta_score = score - score_was
      end

      # Update delta wins
      if first_place?
        delta_wins = 1
      elsif position_was == 0
        delta_wins = -1
      end

      UpdatePlayerJob.perform_later(
        self.player,
        delta_score,
        delta_plays,
        delta_wins
      )

    end

  end


  ###
  # Updates the corresponding players stats.
  def destroy_stats

    delta_wins = 0
    is_first   = (not position_changed? and position == 0)
    was_first  =     (position_changed? and position_was == 0)

    if is_first or was_first
      delta_wins = -1
    end

    UpdatePlayerJob.perform_later(
      self.player,
      -1 * score,
      -1,
      delta_wins
    )

  end

end
