class Region < ApplicationRecord

  has_many :players_regions,
           class_name: 'PlayersRegions',
           dependent: :nullify
  has_many :players, through: :players_regions

  has_many :venues

  validates :slug,
            presence: true,
            uniqueness: true

  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 3..64 }

end
