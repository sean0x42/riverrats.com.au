module Admin::EventsHelper


  ###
  # Renders a set of textboxes, one for each day of the week.
  # @param [FormHelper] form Form object.
  # @param [Event] event Parent event model.
  def week_day_checkboxes (form, event)

    selected_days = []

    # Updated selected days if this is a recurring event
    if event.type == RecurringEvent.sti_name
      selected_days = event.selected_days
    end

    render partial: 'admin/events/checkboxes', locals: {
      selected: selected_days,
      week_days: days_of_the_week,
      form: form
    }

  end

  def days_of_the_week
    %w(sunday monday tuesday wednesday thursday friday saturday)
  end

end
