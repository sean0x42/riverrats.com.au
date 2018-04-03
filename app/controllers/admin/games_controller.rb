require 'set'

class Admin::GamesController < ApplicationController

  before_action :authenticate_player!

  # GET /admin/games
  def index
    @games = Game.all
  end

  # GET /admin/games/new
  def new
    @game = Game.new
    @names = {}
  end

  # POST /admin/games
  def create
    @game = Game.new games_params

    if @game.save
      flash[:notice] = t('game.create')  % { game: @game.name }
      redirect_to admin_games_path
    else
      @names = retrieve_names_from_params params
      render 'new'
    end
  end

  # GET /admin/games/:id/edit
  def edit
    @game = Game.find params[:id]
    @names = retrieve_names_from_existing params[:id]
  end

  # POST /admin/games/:id
  def update
    @game = Game.find params[:id]

    if @game.update games_params
      flash[:notice] = t('game.update') % { game: @game.name }
      redirect_to admin_games_path
    else
      @names = retrieve_names_from_params params
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


  ###
  # Retrieves a hash of player names.
  # @param [Hash] params A hash of all parameters
  # @return [Hash] A hash in the form { player_id: player_full_name }
  def retrieve_names_from_params (params)

    players = Set.new

    # Add players
    if params[:game].has_key? :games_players_attributes
      attributes = params[:game][:games_players_attributes].values
      players.merge attributes.map { |set| set[:player_id] }
    end

    # Add referees
    if params[:game].has_key? :referees_attributes
      attributes = params[:game][:referees_attributes].values
      players.merge attributes.map { |set| set[:player_id] }
    end

    to_name_hash Player.where(id: players.to_a)

  end


  ###
  # Retrieves a hash of player names.
  # @param [Integer] game_id Game to retrieve players from.
  # @return [Hash] A hash in the form { player_id => player_full_name }
  def retrieve_names_from_existing (game_id)

    # Get all players and referees
    players  = Player.joins(:games_players).where(games_players: { game_id: game_id })
    referees = Player.joins(:referees).where(referees: { game_id: game_id })

    # Join using an SQL union
    join = Player.from("(#{players.to_sql} UNION #{referees.to_sql}) AS players")

    to_name_hash join

  end


  ###
  # Converts a collection of +players+ into a hash.
  # @param [Collection] players Collection of players.
  # @return [Hash] A hash in the form { player_id => player_username }
  def to_name_hash (players)
    players.map{ |player| [player.id, "@#{player.username}"] }.to_h
  end

end
