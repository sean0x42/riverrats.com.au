# frozen_string_literal: true

# Sends notifications out to player for commentss
class CommentNotificationWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers

  def perform(id, player_id)
    comment = Comment.find(id)
    sender = comment.player
    venue = Venue.joins(:games).find_by(games: { id: comment.game_id })
    Notification.create(
      player_id: player_id,
      icon: :comment,
      message: format(I18n.t('notification.comment'),
                      sender: sender.username,
                      game: comment.game_id.to_s.rjust(2, '0'),
                      venue: venue.name),
      url: game_path(comment.game_id)
    )
  end
end
