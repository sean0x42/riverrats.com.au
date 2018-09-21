require 'flash_message'

class Admin::RegionsController < ApplicationController
  layout 'admin'
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
      flash[:success] = Struct::Flash.new t('admin.regions.create.title'), t('admin.regions.create.body') % { region: @region.name }
      redirect_to admin_regions_path
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
      flash[:success] = Struct::Flash.new t('admin.regions.update.title'), t('admin.regions.update.body') % {region: @region.name }
      redirect_to admin_regions_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/regions/:id
  def destroy
    @region = Region.friendly.find params[:id]
    @region.destroy

    flash[:success] = Struct::Flash.new t('admin.regions.destroy.title'), t('admin.regions.destroy.body') % {region: @region.name }
    redirect_to admin_regions_path
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end
end
