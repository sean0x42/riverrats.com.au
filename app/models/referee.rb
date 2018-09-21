class Referee < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :game, :player, presence: true
end
