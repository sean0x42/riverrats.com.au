class Event < ApplicationRecord

  belongs_to :venue
  belongs_to :season

  validates :venue, :season, :start_at,
            presence: true

  validates :title,
            length: { within: 3..32 },
            allow_nil: true

end
