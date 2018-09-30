# frozen_string_literal: true

# A join table between players and regions.
class PlayersRegion < ApplicationRecord
  belongs_to :region
  belongs_to :player

  default_scope { order(score: :desc) }

  validates :player_id, uniqueness: { scope: [:region_id] }
  validates :region, :player, presence: true
  validates :score, :games_played, :games_won,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
end
