# frozen_string_literal: true

# A join table between players and venues
class PlayersVenue < ApplicationRecord
  belongs_to :venue
  belongs_to :player

  default_scope { order(score: :desc) }

  validates :player_id, uniqueness: { scope: [:venue_id] }
  validates :venue, :player, presence: true
  validates :score, :games_played, :games_won,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }
end
