class EventsController < ApplicationController

  def index
    models = SingleEvent.all
    @events =
  end

  # GET /events/:id
  def show
    @event = Event.find params[:id]
  end

end
