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
              .where('start_at > ?', Time.zone.now - 1.week)
              .page(params[:page])
  end

  # GET /admin/events/new
  def new
    @event = Event.new
  end

  # POST /admin/events
  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:success] = Struct::Flash.new(
        t('admin.events.create.title'),
        t('admin.events.create.body')
      )
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
      flash[:success] = Struct::Flash.new(
        t('admin.events.update.title'),
        t('admin.events.update.body')
      )
      redirect_to admin_events_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/events/:id
  def destroy
    @event = Event.find params[:id]
    @event.destroy_from_date(params[:from])

    flash[:success] = Struct::Flash.new(
      t('admin.events.destroy.title'),
      t('admin.events.destroy.body')
    )
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
