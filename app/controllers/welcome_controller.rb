class WelcomeController < ApplicationController

  # GET /
  def index
    @season = Season.where('start_at < ? and end_at > ?', Time.now, Time.now).first
  end

  def privacy_policy
  end

end
