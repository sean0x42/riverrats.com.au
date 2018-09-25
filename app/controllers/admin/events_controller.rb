# frozen_string_literal: true

require 'flash_message'

# A controller for events in the admin scope
class Admin::EventsController < ApplicationController
  layout 'admin'

  # noinspection RailsParamDefResolve
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/events
  def index
    @events = SingleEvent
              .includes(:venue)
              .where('start_at > ?', Time.zone.now - 3.days)
              .page(params[:page])
  end

  # GET /admin/events/new
  def new
    @event = Event.new
  end

  # POST /admin/events
  def create
    @event = Event.new(create_event_params)

    if @event.save
      redirect_to admin_events_path, notice: t('admin.events.create.flash')
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js { render 'failure' }
      end
    end
  end

  # GET /admin/events/:id/edit
  def edit
    @event = Event.find params[:id]
  end

  # PATCH /admin/events/:id
  def update
    @event = Event.find params[:id]

    if @event.update(edit_event_params)
      redirect_to admin_events_path, notice: t('admin.events.update.flash')
    else
      render 'edit'
    end
  end

  # DELETE /admin/events/:id
  def destroy
    @event = Event.find params[:id]
    @event.destroy_from_date(params[:from])

    redirect_to admin_events_path, notice: t('admin.events.destroy.flash')
  end

  private

  def create_event_params
    params.require(:event).permit(
      :title, :description, :start_at, :venue_id,
      :repeats, :period, :interval, day: []
    )
  end

  def edit_event_params
    params.require(:event).permit(:title, :description, :start_at, :venue_id)
  end
end
