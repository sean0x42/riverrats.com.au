class Venue < ApplicationRecord

  has_many :venue_players
  has_many :players, through: :venue_players

  belongs_to :region

  enum state: [
    :australian_capital_territory,
    :new_south_wales,
    :norther_territory,
    :queensland,
    :south_australia,
    :tasmania,
    :victoria,
    :western_australia
  ]

  validates :slug,
            presence: true,
            uniqueness: true

  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 3..64 }

  validates :region, :state,
            presence: true

  validates :longitude, :latitude,
            presence: true,
            numericality: true

  validates :address, :suburb,
            presence: true,
            length: { within: 3..64 }

end
