class GameAchievementsJob < ApplicationJob
  queue_as :default

  def perform(*players)
    players.each do |player|
      ParticipationAchievement.check_conditions_for player
      ScoreAchievement.check_conditions_for player
      TheBridesmaid.check_conditions_for player
      TheWoodenSpoon.check_conditions_for player
      WinsAchievement.check_conditions_for player
    end
  end
end