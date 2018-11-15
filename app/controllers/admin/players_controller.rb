# frozen_string_literal: true

require 'flash_message'

# A controller for players in the admin scope
class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/players
  def index
    @players = Player.order(score: :desc).page(params[:page])
  end

  # GET /admin/players/:username
  def show
    @player = Player.find_by!(username: params[:username])
  end

  # GET /admin/players/new
  def new
    @player = Player.new
  end

  # POST /admin/players
  def create
    player_params = new_params
    player_params[:password] = Devise.friendly_token(8)
    @player = Player.new(player_params)

    # noinspection RailsChecklist01
    if @player.save
      record_action(:player, 'players.create', player: @player.username)
      PlayerMailer.welcome(@player.id, player_params[:password]).deliver_later
      redirect_to admin_players_path, notice: t('admin.players.create.flash')
    else
      respond_to do |format|
        format.js { render 'failure' }
        format.html { render 'new' }
      end
    end
  end

  # GET /admin/players/:username/edit
  def edit
    @player = Player.find_by!(username: params[:username])
  end

  # PATCH /admin/players/:username
  def update
    @player = Player.find_by!(username: params[:username])

    if @player.update edit_params
      record_action(:player, 'players.update', player: @player.username)
      redirect_to admin_players_path, notice: t('admin.players.update.flash')
    else
      # noinspection RubyResolve
      @player.username = @player.username_was if @player.username_changed?
      respond_to do |format|
        format.html { render 'edit' }
        format.js { render 'failure' }
      end
    end
  end

  # DELETE /admin/players/:username
  def destroy
    @player = Player.find_by!(username: params[:username])
    @player.destroy

    record_action(:player, 'players.destroy', player: @player.username)
    redirect_to admin_players_path, notice: t('admin.players.destroy.flash')
  end

  private

  def new_params
    params.require(:player).permit(:first_name, :nickname, :last_name, :email)
  end

  def edit_params
    params.require(:player).permit(:username, :nickname, :first_name,
                                   :last_name, :email)
  end
end
