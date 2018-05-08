class VenuesController < ApplicationController

  # GET /venues/:slug
  def show
    @venue = Venue.friendly_id.find_by! slug: params[:slug]
    @players = @venue.players_venues.page(params[:page]).per(25)
  end

end
