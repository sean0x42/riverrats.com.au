# frozen_string_literal: true

namespace :recalculate do
  desc 'Asynchronously recalculates every players stats.'
  task player_stats: :environment do
    Player.all.pluck(:id).each do |player_id|
      RecalculatePlayerStatsWorker.perform_async(player_id)
    end
  end

  desc 'Calculates each player\'s global rank.'
  task global_ranks: :environment do
    CalculateRanksWorker.perform_async
  end
end
