module Admin::EventsHelper


  ###
  # Renders a set of textboxes, one for each day of the week.
  # @param [FormHelper] form Form object.
  # @param [Event] event Parent event model.
  def week_day_checkboxes (form, event)

    selected_days = []
    out = ""

    # Updated selected days if this is a recurring event
    if event.type == RecurringEvent.sti_name
      selected_days = event.selected_days
    end

    # Iterate over week days
    days_of_the_week.each_with_index do |week_day, index|

      # Set checkbox options
      options = {
        id: "event_day_#{index}",
        multiple: true,
        checked: selected_days.include?(week_day)
      }

      # Print checkbox & label
      out += form.check_box :day, options, week_day, false
      out += form.label :day, week_day.titleize, for: "event_day_#{index}"
      out += "<br/>"

    end

    out.html_safe

  end

  def days_of_the_week
    %w(sunday monday tuesday wednesday thursday friday saturday)
  end

end
