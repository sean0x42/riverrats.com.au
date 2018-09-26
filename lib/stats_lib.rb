# frozen_string_literal: true

# A lib for dealing with player stats
module StatsLib
  def self.calc_stats(join, condition)
    reset_join(join)
    Rails.logger.debug condition
    GamesPlayer.joins(:game).where(condition).find_in_batches do |batch|
      batch.each do |game_player|
        join.games_played += 1
        join.games_won += 1 if game_player.position.zero?
        join.score += game_player.score
      end
    end
  end

  def self.reset_join(join)
    join.score = 0
    join.games_played = 0
    join.games_won = 0
  end
end