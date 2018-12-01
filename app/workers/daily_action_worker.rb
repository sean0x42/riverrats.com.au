# frozen_string_literal: true

# A worker which runs every day, deleting old actions
class DailyActionWorker
  include Sidekiq::Worker

  def perform
    Action.where('created_at > ?', Time.zone.today - 3.months).delete_all

    # Schedule next worker
    DailyActionWorker.perform_at(1.day.from_now.at_end_of_day)
  end
end
