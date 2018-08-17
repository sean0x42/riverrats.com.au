require 'flash_message'

class Admin::EventsController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/events
  def index
    @events = SingleEvent.includes(:venue).where('start_at > ?', Time.now - 1.weeks).page params[:page]
  end

  # GET /admin/events/new
  def new
    @event = Event.new
  end

  # POST /admin/events
  def create
    @event = Event.new event_params

    if @event.save
      flash[:success] = Struct::Flash.new t('admin.event.create.title'), t('admin.event.create.body') % { event: @event.clean_title }
      redirect_to admin_events_path
    else
      render 'new'
    end
  end

  # GET /admin/events/:id/edit
  def edit
    @event = Event.find params[:id]
  end

  # PATCH /admin/events/:id
  def update
    @event = Event.find params[:id]

    if @event.update event_params
      flash[:success] = Struct::Flash.new t('admin.event.update.title'), t('admin.event.update.body') % { event: @event.clean_title }
      redirect_to admin_events_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/events/:id
  def destroy
    @event = Event.find params[:id]

    if params.has_key? :from
      @events = SingleEvent.where(recurring_event_id: @event.id).where(['id >= ?', params[:from]])
      @events.destroy_all
    end

    @event.destroy
    flash[:success] = Struct::Flash.new t('admin.event.destroy.title'), t('admin.event.destroy.body') % { event: @event.clean_title }
    redirect_to admin_events_path
  end

  private

  def event_params
    params.require(:event).permit(
      :title, :description, :start_at, :venue_id,
      :type, :period, :interval, day: []
    )
  end
end
