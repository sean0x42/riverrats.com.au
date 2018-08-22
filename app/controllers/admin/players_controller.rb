require 'flash_message'

class Admin::PlayersController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/players
  def index
    @players = Player.order(score: :desc).page params[:page]
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
    @player = Player.new player_params

    if @player.save
      flash[:success] = Struct::Flash.new t('admin.players.create.title'), t('admin.players.create.body') % { player: @player.username }
      PlayerMailer.welcome(@player, player_params[:password]).deliver_later
      redirect_to admin_players_path
    else
      respond_to do |format|
        format.js { render 'failure' }
        format.html { render 'new'}
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
      flash[:success] = Struct::Flash.new t('admin.players.update.title'), t('admin.players.update.body') % { player: @player.username }
      redirect_to admin_players_path
    else
      if @player.username_changed?
        @player.username = @player.username_was
      end
      render 'edit'
    end
  end

  # DELETE /admin/players/:username
  def destroy
    @player = Player.find_by!(username: params[:username])
    @player.destroy

    flash[:success] = Struct::Flash.new t('admin.players.destroy.title'), t('admin.players.destroy.body') % { player: @player.username }
    redirect_to admin_players_path
  end

  private

  def new_params
    params[:email] = nil if params.has_key? :email && params[:email].blank?
    params.require(:player).permit(:first_name, :last_name, :email, :is_admin)
  end

  def edit_params
    params[:email] = nil if params.has_key? :email && params[:email].blank?
    params.require(:player).permit(:username, :first_name, :last_name, :email, :is_admin)
  end
end
