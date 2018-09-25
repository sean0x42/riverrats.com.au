# frozen_string_literal: true

# Represents a calendar event (either repeating or single)
class Event < ApplicationRecord
  belongs_to :venue

  validates :venue, :start_at, presence: true
  validates :title,
            length: { within: 3..32 },
            allow_blank: true,
            allow_nil: true
  validates :description,
            length: { maximum: 1024 },
            allow_blank: true,
            allow_nil: true

  def clean_title
    title.blank? || title.nil? ? 'Untitled event' : title
  end

  def occurred?
    start_at < Time.zone.now
  end

  def today?
    start_at > Time.zone.today.at_beginning_of_day &&
      start_at < Time.zone.today.at_end_of_day
  end

  def destroy_from_date(from)
    unless from.nil?
      events = SingleEvent
               .where(recurring_event_id: @event.id)
               .where('id >= ?', from)
      events.destroy_all
    end
    destroy
  end

  def repeats=(value)
    self.type = if value.to_i.zero?
                  SingleEvent.sti_name
                else
                  RecurringEvent.sti_name
                end
  end

  def day=(value)
    becomes(RecurringEvent).day = value
  end

  def selected_days
    becomes(RecurringEvent).selected_days
  end
end
