# frozen_string_literal: true

# A channel for receiving notifications
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_player
  end

  def mark_read(id)
    Notification.find(id).delete
  end
end
