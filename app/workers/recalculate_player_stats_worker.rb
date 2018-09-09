class RecalculatePlayerStatsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(player_id)
    player = Player.includes(:games_players).find(player_id)
    return if player.nil?

    # Rest values
    player.score        = 0
    player.games_played = 0
    player.games_won    = 0

    # Calculate new ones
    player.games_players.each do |game|
      player.score += game.score
      player.games_played += 1
      player.games_won += 1 if game.position == 0
    end

    player.save
  end
end
