# frozen_string_literal: true

# A join table between players and seasons
class PlayersSeason < ApplicationRecord
  belongs_to :season
  belongs_to :player

  validates :player_id, uniqueness: { scope: [:season_id] }
  validates :season, :player, presence: true
  validates :score, :games_played, :games_won, :rank,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
end
