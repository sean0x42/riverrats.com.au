class RecurringEvent < Event
  include IceCube

  belongs_to :venue
  after_create :on_create

  enum period: [
    :daily,
    :weekly,
    :monthly,
    :yearly
  ]

  validates :title,
            length: {within: 3..32},
            allow_blank: true

  validates :period,
            presence: true

  validates :interval,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 0
            }

  def day= (value)
    self.days = value.to_json
  end

  def selected_days
    JSON.parse(self.days || '[]')
  end

  def on_create
    EventGeneratorJob.perform_now self
  end

  ##
  # Returns an SQL statement with this recurring event's values escaped.
  def escaped_values
    RecurringEvent.send(:sanitize_sql, [
      "(?, ?, ?, ?, ?, '%{time}', ?, ?)",
      title, description,
      SingleEvent.sti_name,
      id, self.venue_id,
      Time.now, Time.now
    ])
  end

  ##
  # Constructs and returns an IceCube schedule.
  def get_schedule

    # Handle all possible period types
    case period
    when 'daily'
      rule = Rule.daily(interval)
    when 'weekly'
      days = selected_days.map(&:to_sym)
      rule = Rule.weekly(interval).day(days)
    when 'monthly'
      rule = Rule.monthly(interval)
    when 'yearly'
      rule = Rule.yearly(interval)
    else
      return period
    end

    Schedule.new(start_at) do |s|
      s.add_recurrence_rule(rule)
    end

  end

end
