class SeasonsController < ApplicationController
  layout 'application'

  def index
    @season = Season.where('start_at < ? and end_at > ?', Time.now, Time.now).first
    redirect_to season_path(@season)
  end

  def show
    @season = Season.find params[:id]
    @players = @season.players_seasons.order(score: :desc).page(params[:page]).per(25)
    @games_played = Game.where(season_id: @season.id).count
  end
end
