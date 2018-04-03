class ScoreAchievementJob < ApplicationJob
  queue_as :default

  def perform(*players)
    players.each do |player|
      ScoreI.check_conditions_for player
    end
  end
end
