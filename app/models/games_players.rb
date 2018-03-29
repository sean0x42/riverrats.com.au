class GamesPlayers < ApplicationRecord

  belongs_to :game
  belongs_to :player

  validates :game, :player,
            presence: true

  validates :position,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

end
