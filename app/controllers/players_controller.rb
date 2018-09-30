# frozen_string_literal: true

# A controller for players
class PlayersController < ApplicationController
  # GET /players
  def index
    @players = Player.page params[:page]
  end

  # GET /players/search
  def search
    @players = Player.search params[:query],
                             page: params[:page],
                             fields: %i[full_name username],
                             match: :word_start
  end

  # GET /players/:username
  def show
    @player = Player
              .includes(:achievements)
              .find_by!(username: params[:username])
  end

  # GET /players/auto-complete
  def auto_complete
    options = {
      fields: %i[full_name username],
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
    # noinspection RubyResolve
    redirect_to player_path(Player.pluck(:username).sample)
  end
end
