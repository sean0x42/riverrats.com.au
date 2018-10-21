# frozen_string_literal: true

# A worker for creating and sending notifications
class GameNotificationWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers
  sidekiq_options queue: 'low_priority'

  def perform(game_player_id, player_id, scope = 'create')
    player = Player.find(player_id)
    game_player = GamesPlayer.find(game_player_id)
    game_id = game_player.game.id
    venue = Venue.joins(:games).find_by(games: { id: game_id })
    notification = create_notification(scope, player_id, game_player.position, game_id, venue.name)
    NotificationChannel.broadcast_to(player, notification)
  end

  private

  def create_notification(scope, player_id, position, game_id, venue_name)
    notification = Notification.new player_id: player_id,
                                    url: game_path(game_id),
                                    icon: :game
    notification.message = format(
      I18n.t("notification.game.#{scope}"),
      position: position.ordinalize,
      game: "##{game_id.to_s.rjust(2, '0')}",
      venue: venue_name
    )
    notification.save
    notification
  end
end
