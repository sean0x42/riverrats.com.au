class Admin::RegionsController < ApplicationController

  # GET /admin/regions
  def index
    @regions = Region.all
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

  # GET /admin/regions/:slug/edit
  def edit
    @region = Region.find_by! slug: params[:slug]
  end

  # PATCH /admin/regions/:slug
  def update
    @region = Region.find_by! slug: params[:slug]

    if @region.update region_params
      flash[:notice] = t('region.update') % {region: @region.name }
      redirect_to admin_regions_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/regions/:slug
  def destroy
    @region = Region.find_by! slug: params[:slug]
    @region.destroy

    flash[:notice] = t('region.destroy') % {region: @region.name }
    redirect_to admin_regions_path
  end

  private

    def region_params
      params.require(:region).permit(:name)
    end
end
