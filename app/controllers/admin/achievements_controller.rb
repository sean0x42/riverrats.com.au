class Admin::AchievementsController < ApplicationController

  # GET /admin/achievements
  def index
  end

  # GET /admin/achievements/new
  def new
    @achievement = Achievement.new
  end

  # POST /admin/achievements
  def create
    @achievement = Achievement.new achievement_params

    if @achievement.save
      flash[:notice] = t('achievement.award') % {
        type: Object.const_get(@achievement.type).title,
        player: "@#{@achievement.player.username}"
      }
      redirect_to admin_achievements_path
    else
      if params.has_key? :achievement and params[:achievement].has_key? :player_id
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
