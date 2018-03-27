class RegionPlayer < ApplicationRecord

  belongs_to :region
  belongs_to :player

  validates :region, :player,
            presence: true

  validates :score, :games_played, :games_won,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
