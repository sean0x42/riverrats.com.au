class PlayersVenues < ApplicationRecord

  belongs_to :venue
  belongs_to :player

  default_scope { order(score: :desc) }

  validates :venue, :player,
            presence: true

  validates :score, :games_played, :games_won,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates_uniqueness_of :player_id, scope: [:venue_id]

end
