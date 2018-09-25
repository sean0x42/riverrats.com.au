class RecurringEventUpdateJob < ApplicationJob
  queue_as :low_priority

  def perform(event)
    start_date = (Time.now.at_beginning_of_day + 6.months).beginning_of_month
    end_date   = (Time.now.at_midnight         + 6.months).end_of_month
    schedule   = event.schedule
    new_times  = schedule.occurrences_between(start_date, end_date, spans: true)

    return if SingleEvent.exists?(start_at: new_times, recurring_event_id: event.id)

    EventGeneratorJob.mass_insert(event, new_times)
    SingleEvent.reindex async: true
  end
end
