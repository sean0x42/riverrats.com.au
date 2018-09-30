# frozen_string_literal: true

# A controller for seasons
class SeasonsController < ApplicationController
  # GET /seasons
  def index
    redirect_to season_path(Season.where_current.pluck(:id))
  end

  # GET /seasons/:id
  def show
    @season = Season.find params[:id]
  end
end
