class PlayersRegions < ApplicationRecord

  belongs_to :region
  belongs_to :player

  default_scope { order(score: :desc) }

  validates :region, :player,
            presence: true

  validates :score, :games_played, :games_won,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates_uniqueness_of :player_id, scope: [:region_id]

end
