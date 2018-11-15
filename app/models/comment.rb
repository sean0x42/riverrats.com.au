# frozen_string_literal: true

# A comment on a game
class Comment < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :body, presence: true, length: { within: 3..440 }
end
