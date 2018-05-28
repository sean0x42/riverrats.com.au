class Admin::RegionsController < ApplicationController

  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/regions
  def index
    if params.has_key? :query
      @regions = Region.search params[:query], page: params[:page], per_page: 25
    else
      @regions = Region.page params[:page]
    end
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

  def require_admin
    unless current_player.is_admin
      flash[:success] = FlashMessage.new 'Permission denied', 'You do not have permission to access this page.'
      redirect_to root_path
    end
  end
end
