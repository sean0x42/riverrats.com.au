# frozen_string_literal: true

# A worker which should be scheduled to run daily. Generates events into the
# future.
class DailyEventWorker
  include Sidekiq::Worker

  def perform
    RecurringEvent.all.pluck(:id) do |event|
      GenerateSingleEventsWorker.perform_async(event)
    end

    # Schedule next event
    DailyEventWorker.perform_at(1.day.from_now.at_beginning_of_day)
  end
end
