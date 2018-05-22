require 'koala'

class WelcomeController < ApplicationController

  # GET /
  def index
    @season = Season.where('start_at < ? and end_at > ?', Time.now, Time.now).first
    @recent_games = Game.all.first(12)

    # Get facebook images
    # graph = Koala::Facebook::API.new
    # @images = graph.get_connection('173011793321380', 'photos', {
    #   limit: 5,
    #   fields: ['images'],
    # }).raw_response
  end

  def privacy_policy
  end

end
