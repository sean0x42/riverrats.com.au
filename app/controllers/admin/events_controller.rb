class Admin::EventsController < ApplicationController

  before_action :authenticate_player!

  # GET /admin/events
  def index
    @events = Event.all
  end

  def new
  end

  def edit
  end
end
