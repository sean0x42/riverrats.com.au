# frozen_string_literal: true

# A controller for seasons
class SeasonsController < ApplicationController
  # GET /seasons
  def index
    @season = Season.reorder(id: :desc).first
    redirect_to season_path(@season)
  end

  # GET /seasons/:id
  def show
    @season = Season.find params[:id]
  end
end
