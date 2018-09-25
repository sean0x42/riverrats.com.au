# frozen_string_literal: true

# A type of event that recurs after at a specified interval
class RecurringEvent < Event
  include IceCube

  belongs_to :venue
  after_save :generate_single_events

  enum period: %i[daily weekly monthly yearly]

  validates :title, length: { within: 3..32 }, allow_blank: true
  validates :period, presence: true
  validates :interval,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  def day=(value)
    self.days = value.to_json
  end

  def selected_days
    JSON.parse(days || '[]')
  end

  # Returns an SQL statement with this recurring event's values escaped.
  def escaped_values
    RecurringEvent.send(:sanitize_sql,
                        ["(?, ?, ?, ?, ?, '%<time>', ?, ?)", title, description,
                         SingleEvent.sti_name, id, venue_id, Time.zone.now,
                         Time.zone.now])
  end

  def schedule
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

  def self.period_map
    periods.keys.map { |period| [period.upcase_first, period] }
  end

  private

  def generate_single_events
    GenerateSingleEventsWorker.perform_async id
  end
end
