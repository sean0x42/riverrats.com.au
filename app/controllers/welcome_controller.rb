class WelcomeController < ApplicationController

  # GET /
  def index
    @season = Season.where('start_at < ? and end_at > ?', Time.now, Time.now).first
    @players = @season.players_seasons.order(score: :desc).page(params[:page]).per(25)
    @games_played = Game.where(season_id: @season.id).count
  end

  def privacy_policy

  end

end
