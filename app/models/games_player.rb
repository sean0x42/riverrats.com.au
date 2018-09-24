# frozen_string_literal: true

# A join table between games and players
class GamesPlayer < ApplicationRecord
  include ActiveModel::Dirty

  default_scope { order(position: :asc) }

  belongs_to :game
  belongs_to :player
  after_save :update_stats
  after_destroy :update_stats

  validates :game, :player, presence: true
  validates :position, :score,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  def first_place?
    position.zero?
  end

  def was_first_place?
    position_was.zero?
  end

  private

  def update_stats
    CalculatePlayerStatsWorker.perform_async(player.id)
  end
end
