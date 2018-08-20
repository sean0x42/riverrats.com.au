class GamesPlayer < ApplicationRecord
  include ActiveModel::Dirty

  default_scope { order(position: :asc)}

  belongs_to :game
  belongs_to :player

  validates :game, :player, presence: true
  validates :position, :score,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  def first_place?
    position == 0
  end

  def was_first_place?
    position_was == 0
  end
end
