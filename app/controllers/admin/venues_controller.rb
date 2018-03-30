class Admin::VenuesController < ApplicationController

  # GET /admin/venues
  def index
    @venues = Venue.all
  end

  # GET /admin/venues/new
  def new
    @venue = Venue.new
  end

  # POST /admin/venues
  def create
    @venue = Venue.new venue_params

    if @venue.save
      flash[:notify] = t('venue.create') % {venue: @venue.name }
      redirect_to admin_venues_path
    else
      render 'new'
    end
  end

  # GET /admin/venue/:slug/edit
  def edit
    @venue = Venue.find_by! slug: params[:slug]
  end

  private

    def venue_params
      params.require(:venue).permit(:name, :region_id, :address, :suburb, :state)
    end
end
