# frozen_string_literal: true

# Deletes old notifications
class DailyNotificationWorker
  include Sidekiq::Worker

  def perform
    Notification.where('created_at < ?', Time.zone.today - 1.week).destroy_all

    DailyNotificationWorker.perform_at(1.day.from_now.at_beginning_of_day)
  end
end
