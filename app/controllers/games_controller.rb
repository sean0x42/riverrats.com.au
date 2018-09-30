# frozen_string_literal: true

# A controller for games
class GamesController < ApplicationController
  # GET /games/
  def index
    @games = Game.includes(:venue).page(params[:page]).per(50)
  end

  # GET /games/:id
  def show
    @game = Game.includes(:venue).find(params[:id])
  end
end
