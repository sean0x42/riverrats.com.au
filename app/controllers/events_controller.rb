class EventsController < ApplicationController

  def index
  end

  # GET /events/:id
  def show
    @event = Event.find params[:id]
  end

end
