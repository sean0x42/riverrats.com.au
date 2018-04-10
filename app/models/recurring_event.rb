class RecurringEvent < Event

  belongs_to :venue

  enum period: [
    :daily,
    :weekly,
    :monthly,
    :yearly
  ]

  validates :title,
            length: { within: 3..32 },
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

end
