class GamesController < ApplicationController

  # GET /games/:id
  def show
    @game = Game.find params[:id]
  end

end
