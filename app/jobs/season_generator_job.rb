class SeasonGeneratorJob < ApplicationJob
  queue_as :default

  def perform
    unless Season.where("start_at <= ? AND end_at >= ?", Date.tomorrow, Date.tomorrow).exists?
      Season.create(
        start_at: Date.tomorrow.beginning_of_quarter,
        end_at: Date.tomorrow.end_of_quarter
      )
    end
  end

  after_perform do
    self.class.set(wait_until: Date.tomorrow.at_beginning_of_day).perform_later
  end
end
