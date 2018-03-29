class PlayersController < ApplicationController

  # GET /players/:username
  def show
    @player = Player.find_by! username: params[:username]
  end

end
