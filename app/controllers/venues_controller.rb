# frozen_string_literal: true

# A controller for venues
class VenuesController < ApplicationController
  # GET /venues/:slug
  def show
    @venue = Venue.friendly_id
                  .includes(:players_venues, :players)
                  .find_by!(slug: params[:slug])
  end
end
