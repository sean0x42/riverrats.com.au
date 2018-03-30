class PlayersController < ApplicationController

  # GET /players/:username
  def show
    @player = Player.find_by! username: params[:username]
  end

  # GET /players/auto-complete
  def auto_complete
    render json: Player.search(params[:query], {
      fields: %w(full_name username),
      match: :text_start,
      limit: 10,
      load: false,
      misspellings: false
    }).map { |player| {
      name: player.full_name,
      username: player.username
    }}
  end

end
