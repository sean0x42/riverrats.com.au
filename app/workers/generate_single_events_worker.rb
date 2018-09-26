# frozen_string_literal: true

require 'event_lib'

# A worker which automatically generates single events for a recurring event
class GenerateSingleEventsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'low_priority'

  def perform(recurring_event_id)
    recurring_event = RecurringEvent.includes(:venue).find(recurring_event_id)
    times = recurring_event.schedule.occurrences(Time.zone.now + 6.months)
    times.each do |time|
      EventLib.clone_event(recurring_event, time)
    end
  end
end
