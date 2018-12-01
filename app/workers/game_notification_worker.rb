# frozen_string_literal: true

# A worker for creating and sending notifications
class GameNotificationWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers
  sidekiq_options queue: 'low_priority'

  def perform(id, player_id)
    player = GamesPlayer.find(id)
    Notification.create(
      player_id: player_id,
      icon: :game,
      message: message(player),
      url: game_path(player.game_id)
    )
  end

  private

  def message(player)
    venue = Venue.joins(:games).find_by(games: { id: player.game_id })
    format(I18n.t('notification.game'),
           position: (player.position + 1).ordinalize,
           game: player.game_id.to_s.rjust(2, '0'),
           venue: venue.name)
  end
end
