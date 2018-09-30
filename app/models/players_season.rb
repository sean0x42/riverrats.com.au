# frozen_string_literal: true

# A join table between players and seasons
class PlayersSeason < ApplicationRecord
  default_scope { order(rank: :asc, score: :desc) }

  belongs_to :season
  belongs_to :player

  validates :player_id, uniqueness: { scope: [:season_id] }
  validates :season, :player, presence: true
  validates :score, :games_played, :games_won,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  # We need two separate declarations because ranks may be nil
  validates :rank,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            allow_nil: true
end
