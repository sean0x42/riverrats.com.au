# frozen_string_literal: true

# A single notification item.
class Notification < ApplicationRecord
  default_scope { order(created_at: :desc) }

  enum icon: %i[game comment]
  belongs_to :player

  validates :message, presence: true, length: { within: 5..200 }
end
