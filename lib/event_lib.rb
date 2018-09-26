# frozen_string_literal: true

# A lib for dealing with events.
module EventLib
  def self.clone_event(recurring_event, time)
    SingleEvent.create do |event|
      event.title = recurring_event.title
      event.venue_id = recurring_event.venue.id
      event.start_at = time
      event.description = recurring_event.description
      event.recurring_event_id = recurring_event.id
    end
  end
end
