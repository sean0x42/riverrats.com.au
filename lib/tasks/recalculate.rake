namespace :recalculate do
  desc "Asynchronously recalculates every players score, games_played, and games_won stats."
  task player_stats: :environment do
    Player.all.pluck(:id).each do |player_id|
      RecalculatePlayerStatsWorker.perform_async(player_id)
    end
  end
end
