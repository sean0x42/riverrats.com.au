class GenerateSeasonWorker
  include Sidekiq::Worker

  def perform
    unless Season.where("start_at <= ? AND end_at >= ?", Date.tomorrow, Date.tomorrow).exists?
      Season.create(
        start_at: Date.tomorrow.beginning_of_quarter,
        end_at: Date.tomorrow.end_of_quarter
      )
    end
  end
end
