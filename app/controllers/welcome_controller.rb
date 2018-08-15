require 'koala'

class WelcomeController < ApplicationController

  # GET /
  def index
    @season = Season.where('start_at <= ? and end_at >= ?', Date.today, Date.today).first
  end

  def privacy_policy
  end

end
