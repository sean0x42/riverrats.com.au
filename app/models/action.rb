# frozen_string_literal: true

# Represents a single administrative action in the admin panel
class Action < ApplicationRecord
  enum action: %i[tickets]

  with_options presence: true do
    validates :action
    validates :description, length: { within: 3..140 }
  end
end
