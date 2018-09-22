# frozen_string_literal: true

# Represents a calendar event (either repeating or single)
class Event < ApplicationRecord
  belongs_to :venue

  validates :venue, :start_at, presence: true
  validates :title, length: { within: 3..32 }, allow_blank: true, allow_nil: true
  validates :description, length: { maximum: 1024 }, allow_blank: true, allow_nil: true

  def clean_title
    title.blank? || title.nil? ? 'Untitled event' : title
  end

  def has_occurred?
    self.start_at < Time.zone.now
  end

  def today?
    self.start_at > Time.zone.today.at_beginning_of_day && self.start_at < Time.zone.today.at_end_of_day
  end

  def destroy_from_date(from)
    unless from.nil?
      events = SingleEvent.where(recurring_event_id: @event.id).where('id >= ?', from)
      events.destroy_all
    end
    self.destroy
  end
end
