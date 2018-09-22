# frozen_string_literal: true

# A helper for admin events
module Admin::EventsHelper
  def week_day_checkboxes(form, event)
    selected_days = []

    # Updated selected days if this is a recurring event
    selected_days = event.selected_days if event.type == RecurringEvent.sti_name

    render partial: 'admin/events/checkboxes', locals: {
      selected: selected_days,
      week_days: %w[sunday monday tuesday wednesday thursday friday saturday],
      form: form
    }
  end
end
