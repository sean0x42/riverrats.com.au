class RecurringEvent < ApplicationRecord
  include IceCube

  belongs_to :venue

  serialize :schedule, Schedule

  validates :title,
            length: { within: 3..32 },
            allow_blank: true

  def schedule
    Schedule.new(self.start_date) do |s|
      s.add_recurrence_rule Rule.daily(1).count(7)
    end
  end

end
