class VenuesController < ApplicationController

  # GET /venues/:slug
  def show
    @venue = Venue.friendly_id.find_by! slug: params[:slug]
  end

end
