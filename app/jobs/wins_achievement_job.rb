class WinsAchievementJob < ApplicationJob
  queue_as :default

  def perform(*players)
    players.each do |player|
      WinsI.check_conditions_for player
    end
  end

end
