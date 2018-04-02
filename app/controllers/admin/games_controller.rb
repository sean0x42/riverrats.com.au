class Admin::GamesController < ApplicationController

  before_action :authenticate_player!

  # GET /admin/games
  def index
    @games = Game.all
  end

  # GET /admin/games/new
  def new
    @game = Game.new
  end

  # POST /admin/games
  def create
    @game = Game.new games_params

    if @game.save
      flash[:notice] = t('game.create')  % { game: @game.name }
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
      flash[:notice] = t('game.update') % { game: @game.name }
      redirect_to admin_games_path
    else
      render 'edit'
    end
  end

  # DELETE /admin/games/:id
  def destroy
    @game = Game.find params[:id]
    @game.destroy

    flash[:notice] = t('game.destroy')  % { game: @game.name }
    redirect_to admin_games_path
  end

  private

  def games_params
    params.require(:game).permit(
      :venue_id, :season_id,
      games_players_attributes: [:id, :player_id, :position, :_destroy],
      referees_attributes: [:id, :player_id, :_destroy]
    )
  end

end
