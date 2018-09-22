# frozen_string_literal: true

# A controller for regions
class RegionsController < ApplicationController
  # GET /regions/:slug
  def show
    @region = Region.friendly_id
                    .includes(:venues)
                    .find_by!(slug: params[:slug])
  end
end
