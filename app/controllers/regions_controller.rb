class RegionsController < ApplicationController
  # GET /regions/:slug
  def show
    @region = Region.includes(:venues).friendly_id.find_by!(slug: params[:slug])
  end
end
