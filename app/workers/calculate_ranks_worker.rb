# Calculates each players global ranking
class CalculateRanksWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'low_priority'

  def perform
    Player.select('id, rank() OVER (ORDER BY score DESC, username ASC) AS rank').each do |player|
      Player.find(player.id).update(rank: player.rank - 1)
    end
  end
end
