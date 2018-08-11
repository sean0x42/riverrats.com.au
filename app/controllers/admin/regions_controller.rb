require 'flash_message'

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
      flash[:success] = Struct::Flash.new t('admin.region.create.title'), t('admin.region.create.body') % { region: @region.name }
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
      flash[:success] = Struct::Flash.new t('admin.region.update.title'), t('admin.region.update.body') % {region: @region.name }
      redirect_to admin_regions_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/regions/:id
  def destroy
    @region = Region.friendly.find params[:id]
    @region.destroy

    flash[:success] = Struct::Flash.new t('admin.region.destroy.title'), t('admin.region.destroy.body') % {region: @region.name }
    redirect_to admin_regions_path
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end
end
