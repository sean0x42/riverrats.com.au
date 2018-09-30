# frozen_string_literal: true

# A worker which runs daily, checking if a new season needs to be generated.
class DailySeasonWorker
  include Sidekiq::Worker

  def perform
    date = Time.zone.now + 3.days
    unless Season.where_current(date).exists?
      Season.create(
        start_at: date.beginning_of_quarter,
        end_at: date.end_of_quarter
      )
    end

    # Schedule next event
    DailySeasonWorker.perform_at(1.day.from_now.at_beginning_of_day)
  end
end
