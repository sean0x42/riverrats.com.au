class VenuesController < ApplicationController
  # GET /venues/:slug
  def show
    @venue = Venue.includes(:players_venues, :players).friendly_id.find_by!(slug: params[:slug])
  end
end
