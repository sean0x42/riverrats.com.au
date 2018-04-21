class Admin::EventsController < ApplicationController

  layout 'admin'
  before_action :authenticate_player!

  # GET /admin/events
  def index

    all = SingleEvent.order(start_at: :desc)

    if params.has_key? :query
      @events = SingleEvent.search params[:query], page: params[:page], per_page: 25
    else
      @events = SingleEvent.order(start_at: :desc).where('start_at > ?', Time.now - 2.weeks).page params[:page]
    end

    @stats = {
      finished: all.where('start_at < ?', Time.now).count,
      upcoming: all.where('start_at > ? AND start_at < ?', Time.now, Time.now + 2.weeks).count,
      recurring: RecurringEvent.count
    }

  end

  # GET /admin/events/new
  def new
    @event = Event.new
  end

  # POST /admin/events
  # noinspection RailsChecklist01
  def create
    @event = Event.new event_params

    if @event.save
      flash[:success] = FlashMessage.new(
        'Success!',
        t('event.create') % {
          event: @event.clean_title,
          link: event_path(@event)
        }
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
      redirect_to admin_events_path, notice: t('event.update') % { event: @event.clean_title }
    else
      render 'edit'
    end
  end

  # DELETE /admin/events/:id
  def destroy
    @event = Event.find params[:id]
    @event.destroy

    redirect_to admin_events_path, notice: t('event.destroy') % { event: @event.clean_title }
  end

  private

    def event_params
      params.require(:event).permit(
        :title, :description, :start_at, :venue_id,
        :type, :period, :interval, day: []
      )
    end

end
