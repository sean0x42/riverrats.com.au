class GamesPlayers < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :game
  belongs_to :player

  validates :game, :player,
            presence: true

  validates :position, :score,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates_uniqueness_of :game_id, scope: [:player_id]

  ###
  # Returns whether this player is in first place.
  # @return [Boolean] Whether the player is in first.
  def first_place?
    position == 0
  end

  ##
  # Returns whether this player was in first place.
  # @return [Boolean] Whether the player was in first.
  def was_first_place?
    position_was == 0
  end

end
