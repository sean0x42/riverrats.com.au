# frozen_string_literal: true

# A venue that hosts games for the league
class Venue < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]

  default_scope { order(:name) }

  has_attached_file :image, styles: { regular: ['1400x1400>', :png] }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :players_venues, class_name: 'PlayersVenue', dependent: :nullify,
                            inverse_of: :venue
  has_many :players, through: :players_venues
  belongs_to :region

  enum state: %i[ACT NSW NT QLD SA TAS VIC WA]

  with_options presence: true do
    validates :name, uniqueness: true, length: { within: 3..128 }
    validates :slug, :address_line_one, :suburb, :post_code, :state,
              :phone_number
  end

  with_options allow_nil: true, allow_blank: true do
    validates :address_line_one, :address_line_two, length: { within: 3..128 }
    validates :facebook, format: {
      with: /\Ahttps:\/\/www.facebook.com\//,
      message: 'URL must be a valid URL to a Facebook page.'
    }
    validates :website, format: {
      with: /\Ahttps?:\/\//,
      message: 'must be a valid URL.'
    }
  end

  def search_data
    { name: name }
  end

  def paginated_players(page)
    PlayersVenue.includes(:player).where(venue: self).page(page).per(25)
  end
end
