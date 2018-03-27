class Region < ApplicationRecord

  has_many :region_players
  has_many :players, through: :region_players

  has_many :venues

  validates :slug,
            presence: true,
            uniqueness: true

  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 3..64 }

end
