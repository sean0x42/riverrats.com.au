# frozen_string_literal: true

# A region covered by the league
class Region < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  default_scope { order(:name) }

  searchkick callbacks: :async

  has_many :players_regions, class_name: 'PlayersRegion', dependent: :nullify,
                             inverse_of: :region
  has_many :players, through: :players_regions
  has_many :venues, dependent: :nullify

  with_options presence: true do
    validates :name, uniqueness: true, length: { within: 3..64 }
    validates :slug
  end

  def search_data
    { name: name }
  end

  def paginated_players(page)
    PlayersRegion.includes(:player).where(region: self).page(page).per(25)
  end
end
