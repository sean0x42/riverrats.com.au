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
  end

  # POST /admin/games
  def create
    @game = Game.new games_params

    if @game.save
      flash[:success] = Struct::Flash.new t('admin.games.create.title'), t('admin.games.create.body')  % { game: @game.name }
      redirect_to admin_games_path
    else
      render 'new'
    end
  end

  # GET /admin/games/:id/edit
  def edit
    @game = Game.find params[:id]
  end

  # POST /admin/games/:id
  def update
    @game = Game.find params[:id]

    if @game.update games_params
      # @game.update_ranks TODO Add an after update task to queue this job
      flash[:success] = Struct::Flash.new t('admin.games.update.title'), t('admin.games.update.body') % { game: @game.name }
      redirect_to admin_games_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/games/:id
  def destroy
    @game = Game.find params[:id]
    @game.destroy

    flash[:success] = Struct::Flash.new t('admin.games.destroy.title'), t('admin.games.destroy.body')  % { game: @game.name }
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
