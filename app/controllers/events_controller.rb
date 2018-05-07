class EventsController < ApplicationController

  helper_method :next_month
  helper_method :previous_month

  # GET /calendar(/:year/:month)
  def index

    @date = Date.today

    if params.has_key? :year
      # Attempt to parse date
      begin
        @date = Date.parse("#{params[:month]} #{params[:year]}")
      rescue ArgumentError
        raise ActionController::BadRequest.new, 'Could not parse date.'
      end
    end

    @start = @date.beginning_of_month.beginning_of_week(:sunday)
    @finish = @date.end_of_month.end_of_week(:sunday)

    events = SingleEvent
                .where('start_at > ?', @start)
                .where('start_at < ?', @finish)

    # Take our events and bundle them into a hash
    @events = (@start..@finish).map{ |date| [date, []] }.to_h
    events.each do |event|
      @events[event.start_at.to_date].push event
    end

  end

  # GET /events/:id
  def show
    @event = Event.find params[:id]
  end

  private

  def next_month(date)
    date + 1.month
  end

  def previous_month(date)
    date - 1.month
  end

end
