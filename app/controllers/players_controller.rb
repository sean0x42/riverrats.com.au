class PlayersController < ApplicationController

  # GET /players/:username
  def show
    @player = Player.find_by! username: params[:username]
  end

  # GET /players/auto-complete
  def auto_complete
    render json: Player.search(params[:query],
      fields: [:full_name, :username],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: false
    ).map { |player| { id: player.id, name: player.full_name, username: player.username }}
  end

end
