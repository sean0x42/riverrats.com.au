# frozen_string_literal: true

# A comment on a game
class Comment < ApplicationRecord
  default_scope { order(created_at: :asc) }

  after_create :send_notifications

  belongs_to :game
  belongs_to :player

  validates :body, presence: true, length: { within: 3..440 }
  validates :deleted, inclusion: { in: [true, false] }

  protected

  def send_notifications
    CommentNotificationsWorker.perform_async(id)
  end
end
