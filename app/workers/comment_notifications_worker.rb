# frozen_string_literal: true

# Sends notifications out to players for comments
class CommentNotificationsWorker
  include Sidekiq::Worker

  def perform(id)
    comment = Comment.find(id)
    players = Player.joins(:games_players)
                    .where(games_players: { game_id: comment.game_id })
                    .pluck(:id)
    players.each do |player_id|
      next if player_id == comment.player_id

      CommentNotificationWorker.perform_async(id, player_id)
    end
  end
end
