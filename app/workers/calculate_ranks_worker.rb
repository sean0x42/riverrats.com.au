# frozen_string_literal: true

# Calculates each players global ranking
class CalculateRanksWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'low_priority'

  SQL = 'id, rank() OVER (ORDER BY score DESC, username ASC) AS rank'

  def perform
    Player.select(SQL).each do |player|
      Player.find(player.id).update(rank: player.rank - 1)
    end
  end
end
