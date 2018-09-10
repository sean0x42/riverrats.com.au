class PlayersController < ApplicationController
  # GET /players
  def index
    @players = Player.page params[:page]
  end

  # GET /players/:username
  def show
    @player = Player.includes(:achievements).find_by!(username: params[:username])
  end

  # GET /players/auto-complete
  def auto_complete
    options = {
      fields: [:full_name, :username],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: false
    }

    render json: Player.search(params[:query], options).map do |player|
      { id: player.id, name: player.full_name, username: player.username }
    end
  end

  # GET /players/random
  def random
    redirect_to player_path(Player.pluck(:username).shuffle.first)
  end
end
