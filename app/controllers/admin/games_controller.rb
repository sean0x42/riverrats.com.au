class Admin::GamesController < ApplicationController

  # GET /admin/games
  def index
    @games = Game.all
  end

  # GET /admin/games/new
  def new
    @game = Game.new
  end

  # GET /admin/games/:id/edit
  def edit
    @game = Game.find params[:id]
  end

end
