class EventGeneratorJob < ApplicationJob
  include IceCube
  queue_as :default

  def perform(event)
    end_date = (Time.now.at_midnight + 6.months).end_of_month
    schedule = event.schedule
    EventGeneratorJob.mass_insert(event, schedule.occurrences(end_date))
  end

  def self.mass_insert(event, times)
    escaped_values = event.escaped_values
    values = times.map do |time|
      escaped_values % { time: time.utc }
    end
    values = values.join(',')
    sql = "INSERT INTO events (title, description, type, recurring_event_id, venue_id, start_at, created_at, updated_at) VALUES #{values};"
    ActiveRecord::Base.connection.execute(sql)
  end
end
