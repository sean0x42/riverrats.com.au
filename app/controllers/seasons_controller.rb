class SeasonsController < ApplicationController
  # GET /seasons
  def index
    @season = Season.where('start_at < ? and end_at > ?', Time.now, Time.now).first
    redirect_to season_path(@season)
  end

  # GET /seasons/:id
  def show
    @season = Season.find params[:id]
  end
end
