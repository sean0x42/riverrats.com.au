require 'flash_message'

class Admin::GamesController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/games
  # noinspection RailsChecklist01
  def index
    @games = Game.includes(:venue).page params[:page]
  end

  # GET /admin/games/new
  def new
    @game = Game.new
    @attrs = Admin::AttributeCollector.empty_attrs
  end

  # POST /admin/games
  def create
    @game = Game.new games_params

    if @game.save
      flash[:success] = Struct::Flash.new t('admin.game.create.title'), t('admin.game.create.body')  % { game: @game.name }
      redirect_to admin_games_path
    else
      @attrs = Admin::AttributeCollector.from_params params
      render 'new'
    end
  end

  # GET /admin/games/:id/edit
  def edit
    @game = Game.find params[:id]
    @attrs = Admin::AttributeCollector.from_db params[:id]
  end

  # POST /admin/games/:id
  def update
    @game = Game.find params[:id]

    if @game.update games_params
      @game.update_ranks
      flash[:success] = Struct::Flash.new t('admin.game.update.title'), t('admin.game.update.body') % { game: @game.name }
      redirect_to admin_games_path
    else
      @attrs = Admin::AttributeCollector.from_params params
      render 'edit'
    end
  end

  # DELETE /admin/games/:id
  def destroy
    @game = Game.find params[:id]
    @game.destroy

    flash[:success] = Struct::Flash.new t('admin.game.destroy.title'), t('admin.game.destroy.body')  % { game: @game.name }
    redirect_to admin_games_path
  end

  private

  def games_params
    params.require(:game).permit(
      :played_on, :venue_id, :season_id,
      games_players_attributes: [:id, :player_id, :position, :_destroy],
      referees_attributes: [:id, :player_id, :_destroy]
    )
  end
end
