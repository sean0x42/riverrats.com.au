# frozen_string_literal: true

require 'flash_message'

# Controller for achievements in the admin scope
class Admin::AchievementsController < ApplicationController
  layout 'admin'

  # noinspection RailsParamDefResolve
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/achievements/new
  def new
    @achievement = Achievement.new
  end

  # POST /admin/achievements
  def create
    @achievement = Achievement.new achievement_params

    if @achievement.save
      flash[:success] = Struct::Flash.new(
        t('admin.achievements.create.title'),
        t('admin.achievements.create.body')
      )
      redirect_to admin_players_path
    else
      if params.key?(:achievement) && params[:achievement].key?(:player_id)
        @player_name = Player.find(params[:achievement][:player_id]).full_name
      end
      render 'new'
    end
  end

  private

  def achievement_params
    params.require(:achievement).permit(:type, :player_id, :proof)
  end
end
