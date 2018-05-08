class RegionsController < ApplicationController

  # GET /regions/:slug
  def show
    @region = Region.friendly_id.find_by! slug: params[:slug]
    @players = @region.players_regions.page(params[:page]).per(25)
  end

end
