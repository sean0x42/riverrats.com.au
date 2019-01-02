# frozen_string_literal: true

require 'flash_message'

# A controller for venues in the admin scope
class Admin::VenuesController < ApplicationController
  layout 'admin'

  # noinspection RailsParamDefResolve
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/venues
  def index
    @venues = Venue.page params[:page]
  end

  # GET /admin/venues/new
  def new
    @venue = authorize Venue.new
  end

  # POST /admin/venues
  def create
    @venue = authorize Venue.new(venue_params)

    if @venue.save
      record_action(:venue, 'venues.create', venue: @venue.name)
      redirect_to admin_venues_path, notice: t('admin.venues.create.flash')
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js { render 'failure' }
      end
    end
  end

  # GET /admin/venues/:id/edit
  def edit
    @venue = authorize Venue.friendly.find(params[:id])
  end

  # PATCH /admin/venues/:id
  def update
    @venue = authorize Venue.friendly.find(params[:id])

    if @venue.update venue_params
      record_action(:venue, 'venues.update', venue: @venue.name)
      redirect_to admin_venues_path, notice: t('admin.venues.update.flash')
    else
      render 'edit'
    end
  end

  # DELETE /admin/venues/:id
  def destroy
    @venue = authorize Venue.friendly.find(params[:id])
    @venue.destroy

    record_action(:venue, 'venues.destroy', venue: @venue.name)
    redirect_to admin_venues_path, notice: t('admin.venues.destroy.flash')
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :region_id, :address_line_one,
                                  :address_line_two, :suburb, :post_code,
                                  :state, :website, :facebook, :phone_number,
                                  :image)
  end
end
