class RegionsController < ApplicationController

  # GET /regions/:slug
  def show
    @region = Region.friendly_id.find_by! slug: params[:slug]
  end
end
