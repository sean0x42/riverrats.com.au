class Admin::RegionsController < ApplicationController

  before_action :authenticate_player!

  # GET /admin/regions
  def index
    @regions = Region.order(:name).page params[:page]
  end

  # GET /admin/regions/new
  def new
    @region = Region.new
  end

  # POST /admin/regions
  def create
    @region = Region.new region_params

    if @region.save
      flash[:notice] = t('region.create') % {region: @region.name }
      redirect_to admin_regions_path
    else
      render 'new'
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
      flash[:notice] = t('region.update') % {region: @region.name }
      redirect_to admin_regions_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/regions/:id
  def destroy
    @region = Region.friendly.find params[:id]
    @region.destroy

    flash[:notice] = t('region.destroy') % {region: @region.name }
    redirect_to admin_regions_path
  end

  private

    def region_params
      params.require(:region).permit(:name)
    end
end
