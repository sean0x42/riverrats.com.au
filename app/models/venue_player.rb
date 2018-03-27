class VenuePlayer < ApplicationRecord

  belongs_to :venue
  belongs_to :player

  validates :venue, :player,
            presence: true

  validates :score, :games_played, :games_won,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
