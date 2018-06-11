class Referee < ApplicationRecord

  belongs_to :game
  belongs_to :player

  validates :game, :player, presence: true

  # validates_uniqueness_of :game_id, scope: [:player_id]

end
