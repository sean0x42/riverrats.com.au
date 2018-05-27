class GamesController < ApplicationController

  # GET /games/
  def index
    @games = Game.page params[:page]
  end

  # GET /games/:id
  def show
    @game = Game.find params[:id]
    @players = @game.games_players.page params[:page]
  end

end
