# frozen_string_literal: true

# A join table between games and their referees (players)
class Referee < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :game, :player, presence: true
end
