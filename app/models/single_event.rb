# frozen_string_literal: true

# A single calendar event
class SingleEvent < Event
  belongs_to :recurring_event, optional: true
  default_scope { order(:start_at) }

  searchkick callbacks: :async,
             word_start: %i[title description]

  def search_data
    { title: title, description: description }
  end
end
