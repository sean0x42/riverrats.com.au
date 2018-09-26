# frozen_string_literal: true

# A single calendar event
class SingleEvent < Event
  belongs_to :recurring_event, optional: true
  default_scope { order(:start_at) }

  def self.in_the_past
    SingleEvent.where('start_at < ?', Time.zone.now)
  end

  def self.upcoming
    now = Time.zone.now
    SingleEvent.where('start_at > ? AND start_at < ?', now, now + 2.weeks)
  end
end
