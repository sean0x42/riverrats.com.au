# frozen_string_literal: true

namespace :recalculate do
  desc 'Asynchronously recalculates every players stats.'
  task stats: :environment do
    Player.all.pluck(:id).each do |player_id|
      CalculatePlayerStatsWorker.perform_async(player_id)
    end
  end

  desc 'Calculates each player\'s global rank.'
  task ranks: :environment do
    CalculateRanksWorker.perform_async
    CalculateSeasonRanksWorker.perform_async(Season.current.id)
  end
end
