# frozen_string_literal: true

# A controller for seasons
class SeasonsController < ApplicationController
  # GET /seasons
  def index
    now = Time.zone.now
    @season = Season.where('start_at < ? and end_at > ?', now, now).first
    redirect_to season_path(@season)
  end

  # GET /seasons/:id
  def show
    @season = Season.find params[:id]
  end
end
