class EventUpdateJob < ApplicationJob
  queue_as :default

  def perform
    events = RecurringEvent.all
    events.each do |event|
      RecurringEventUpdateJob.perform_later(event)
    end
  end

  after_perform do
    self.class.set(wait_until: Date.today + 1.month).perform_later
  end

end
