# frozen_string_literal: true

require 'flash_message'

# A controller for regions in the admin scope
class Admin::RegionsController < ApplicationController
  layout 'admin'

  # noinspection RailsParamDefResolve
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/regions
  def index
    @regions = Region.page params[:page]
  end

  # GET /admin/regions/new
  def new
    @region = Region.new
  end

  # POST /admin/regions
  def create
    @region = Region.new region_params

    if @region.save
      redirect_to admin_regions_path, notice: t('admin.regions.create.flash')
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js { render 'failure' }
      end
    end
  end

  # GET /admin/regions/:id/edit
  def edit
    @region = Region.friendly.find params[:id]
  end

  # PATCH /admin/regions/:id
  def update
    @region = Region.friendly.find params[:id]

    if @region.update region_params
      redirect_to admin_regions_path, notice: t('admin.regions.update.flash')
    else
      render 'edit'
    end
  end

  # DELETE /admin/regions/:id
  def destroy
    @region = Region.friendly.find params[:id]
    @region.destroy

    redirect_to admin_regions_path, notice: t('admin.regions.destroy.flash')
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end
end
