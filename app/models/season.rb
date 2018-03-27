class Season < ApplicationRecord

  has_many :season_players
  has_many :players, through: :season_players

  validates :start_at, :end_at,
            presence: true

end
