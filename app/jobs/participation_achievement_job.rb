class ParticipationAchievementJob < ApplicationJob
  queue_as :default

  def perform(*players)
    players.each do |player|
      ParticipationI.check_conditions_for player
    end
  end

end