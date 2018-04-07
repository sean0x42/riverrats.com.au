class Admin::EventsController < ApplicationController

  before_action :authenticate_player!

  # GET /admin/events
  def index
    @events = Event.all.first(50)
  end

  # GET /admin/events/new
  def new
    @event = Event.new
  end

  # POST /admin/events
  def create
    @event = Event.new event_params

    if @event.save
      flash[:notice] = t('event.create') % { event: @event.clean_title }
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
      flash[:notice] = t('event.update') % { event: @event.clean_title }
      redirect_to admin_events_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/events/:id
  def destroy
    @event = Event.find params[:id]
    @event.destroy

    flash[:notice] = t('event.destroy') % { event: @event.clean_title }
    redirect_to admin_events_path
  end

  private

    def event_params
      params.require(:event).permit(:title, :start_at, :venue_id)
    end

end
