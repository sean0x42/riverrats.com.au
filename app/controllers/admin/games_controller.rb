# frozen_string_literal: true

# A controller for games in the admin scope
class Admin::GamesController < ApplicationController
  layout 'admin'

  # noinspection RailsParamDefResolve
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/games
  def index
    @games = Game.includes(:venue).page(params[:page])
  end

  # GET /admin/games/new
  def new
    @game = Game.new
  end

  # POST /admin/games
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def create
    @game = Game.new(games_params)

    if @game.save
      @game.award_tickets(params[:game][:tickets])
      record_action(:game, 'games.create', game: @game.id)
      redirect_to admin_games_path, notice: t('admin.games.create.flash')
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js { render 'failure' }
      end
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  # GET /admin/games/:id/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /admin/games/:id
  # rubocop:disable Metrics/AbcSize
  def update
    @game = Game.find(params[:id])

    if @game.update(games_params)
      record_action(:game, 'games.update', game: @game.id)
      redirect_to admin_games_path, notice: t('admin.games.update.flash')
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js { render 'failure' }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # DELETE /admin/games/:id
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    record_action(:game, 'games.destroy', game: @game.id)
    redirect_to admin_games_path, notice: t('admin.games.destroy.flash')
  end

  private

  def games_params
    params.require(:game).permit(
      :played_on, :venue_id, :season_id,
      games_players_attributes: %i[id player_id position _destroy],
      referees_attributes: %i[id player_id _destroy]
    )
  end
end
