class WelcomeController < ApplicationController

  # GET /
  def index
    @season = Season.where('start_at < ? and end_at > ?', Time.now, Time.now).first
    @recent_games = Game.all.first(12)
  end

  def privacy_policy
  end

end
