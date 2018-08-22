class PlayersController < ApplicationController
  # GET /players
  def index
    @players = Player.page params[:page]
  end

  # GET /players/:username
  def show
    @player = Player.find_by! username: params[:username]
    # @achievements = @player.achievements.page(params[:achievements]).per(6)
    # current_season = Season.where('start_at < ? and end_at > ?', Time.now, Time.now).first
    # @season_player = PlayersSeasons.where(player_id: @player.id).where(season_id: current_season.id).first
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
