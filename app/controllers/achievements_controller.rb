class AchievementsController < ApplicationController
  def index
    @player = Player.find_by! username: params[:player_username]
  end

  def show
  end
end
