# frozen_string_literal: true

# Represents a single administrative action in the admin panel
class Action < ApplicationRecord
  belongs_to :player

  enum action: %i[player game event venue region achievement ticket comment]

  with_options presence: true do
    validates :action
    validates :description, length: { minimum: 3 }
  end
end
