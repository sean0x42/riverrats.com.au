class Event < ApplicationRecord
  belongs_to :venue

  validates :venue, :start_at, presence: true
  validates :title, length: { within: 3..32 }, allow_blank: true, allow_nil: true
  validates :description, length: { maximum: 1024 }, allow_blank: true, allow_nil: true

  def clean_title
    title.blank? || title.nil? ? 'Untitled event' : title
  end

  def has_occurred?
    start_at < Time.now
  end

  def today?
    self.start_at > Date.today.at_beginning_of_day && self.start_at < Date.today.at_end_of_day
  end
end
