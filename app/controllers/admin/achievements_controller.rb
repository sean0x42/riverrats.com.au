# frozen_string_literal: true

require 'flash_message'

# Controller for achievements in the admin scope
class Admin::AchievementsController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/players/:player_username/achievements/new
  def new
    @player = Player.find_by!(username: params[:player_username])
    @achievement = @player.achievements.build
  end

  # POST /admin/players/:player_username/achievements
  def create
    @player = Player.find_by!(username: params[:player_username])
    @achievement = @player.achievements.build(achievement_params)

    if @achievement.save
      record_action(:achievement, 'achievements.create',
                    achievement: @achievement.type)
      redirect_to admin_players_path,
                  notice: t('admin.achievements.create.flash')
    else
      render 'new'
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:type, :proof)
  end
end
