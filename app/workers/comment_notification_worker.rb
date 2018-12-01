# frozen_string_literal: true

# Sends notifications out to player for commentss
class CommentNotificationWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers

  def perform(id, player_id)
    comment = Comment.find(id)
    Notification.create(
      player_id: player_id,
      icon: :comment,
      message: message(comment),
      url: game_path(comment.game_id)
    )
  end

  private

  def message(comment)
    venue = Venue.joins(:games).find_by(games: { id: comment.game_id })
    format(I18n.t('notification.comment'),
           sender: comment.player.username,
           game: comment.game_id.to_s.rjust(2, '0'),
           venue: venue.name)
  end
end
