class GamesPlayers < ApplicationRecord

  belongs_to :game
  belongs_to :player

  default_scope { order(:position) }

  validates :game, :player,
            presence: true

  validates :position, :score,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  def first_place?
    position == 0
  end

end
