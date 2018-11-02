# frozen_string_literal: true

require 'score_lib'

# A join table between games and players
class GamesPlayer < ApplicationRecord
  include ActiveModel::Dirty
  include ScoreLib

  default_scope { order(position: :asc) }

  belongs_to :game
  belongs_to :player

  before_save :calc_score
  after_save :update_stats
  after_destroy :update_stats
  after_create :send_create_notification
  after_update :send_update_notification

  with_options presence: true do
    validates :game, :player
    validates :position, :score,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0
              }
  end

  def first_place?
    position.zero?
  end

  def was_first_place?
    position_was.zero?
  end

  def last?
    position == GamesPlayer.where(game_id: game_id).count - 1
  end

  private

  def calc_score
    self.score = calculate_score(position)
  end

  def update_stats
    CalculatePlayerStatsWorker.perform_async(player.id)
  end

  def send_create_notification
    GameNotificationWorker.perform_async(id, player.id, 'create')
  end

  def send_update_notifications
    GameNotificationWorker.perform_async(id, player.id, 'update')
  end
end
