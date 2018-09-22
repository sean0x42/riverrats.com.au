# frozen_string_literal: true

# A venue that hosts games for the league
class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  default_scope { order(:name) }

  searchkick callbacks: :async

  has_attached_file :image, styles: { regular: ['1400x1400>', :png] }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :players_venues, class_name: 'PlayersVenue', dependent: :nullify
  has_many :players, through: :players_venues

  belongs_to :region

  enum state: %i[
    australian_capital_territory
    new_south_wales
    norther_territory
    queensland
    south_australia
    tasmania
    victoria
    western_australia
  ]

  validates :name,
            presence: true,
            uniqueness: true,
            length: { within: 3..128 }

  validates :slug, presence: true

  validates :address_line_one, :address_line_two,
            length: { within: 3..128 },
            allow_nil: true,
            allow_blank: true

  validates :address_line_one, :suburb, :post_code, :state, :phone_number,
            presence: true

  validates :facebook, format: {
    with: /\Ahttps:\/\/www.facebook.com\//,
    message: 'URL must be a valid URL to a Facebook page.'
  }, allow_blank: true, allow_nil: true

  validates :website, format: {
    with: /\Ahttps?:\/\//,
    message: 'must be a valid URL.'
  }, allow_blank: true, allow_nil: true

  def search_data
    { name: name }
  end

  def paginated_players(page)
    PlayersVenue.includes(:player).where(venue: self).page(page).per(25)
  end
end
