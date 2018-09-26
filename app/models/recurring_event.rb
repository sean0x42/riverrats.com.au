# frozen_string_literal: true

# A type of event that recurs after at a specified interval
class RecurringEvent < Event
  include IceCube

  belongs_to :venue
  after_create :generate_single_events

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

  def schedule
    rule = if period == 'weekly'
             Rule.weekly(interval).day(selected_days.map(&:to_sym))
           else
             Rule.send(period, interval)
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
