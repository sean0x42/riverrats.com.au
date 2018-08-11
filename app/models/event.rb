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

  def upcoming?
    start_at > Date.today and start_at < Date.today + 2.weeks
  end
end
