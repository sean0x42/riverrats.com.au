class PlayersController < ApplicationController

  # GET /players
  def index
    if params.has_key? :query
      @players = Player.search params[:query], page: params[:page], per_page: 25
    else
      @players = Player.all
    end
  end

  # GET /players/:username
  def show
    @player = Player.find_by! username: params[:username]
    @recent_games = @player.recent_games
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

  # GET /players/random
  def random
    redirect_to player_path(Player.pluck(:username).shuffle.first)
  end

end
