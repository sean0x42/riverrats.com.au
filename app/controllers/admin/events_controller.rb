class Admin::EventsController < ApplicationController

  # GET /admin/events
  def index
    @events = Event.all
  end

  def new
  end

  def edit
  end
end
