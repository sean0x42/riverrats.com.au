class SeasonPlayer < ApplicationRecord
  belongs_to :season
  belongs_to :player

  validates :season, :player,
            presence: true

  validates :score, :games_played, :games_won,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
