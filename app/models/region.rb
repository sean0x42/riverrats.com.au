class Region < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  paginates_per 50

  has_many :players_regions, class_name: 'PlayersRegions', dependent: :nullify
  has_many :players, through: :players_regions

  has_many :venues, dependent: :nullify

  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 3..64 }

  validates :slug, presence: true

end
