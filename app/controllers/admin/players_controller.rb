class Admin::PlayersController < ApplicationController

  before_action :authenticate_player!

  # GET /admin/players
  def index
    @players = Player.all
  end

  # GET /admin/players/:username
  def show
    @player = Player.find_by! username: params[:username]
  end

  # GET /admin/players/new
  def new
    @player = Player.new
  end

  # POST /admin/players
  # TODO Handle case where no email has been provided.
  def create
    generated_password = Devise.friendly_token(8)

    @player = Player.new do |player|
      player.first_name = auth_params[:first_name]
      player.last_name = auth_params[:last_name]
      player.email = auth_params[:email]
      player.password = generated_password
    end

    if @player.save
      flash[:notice] = t('player.create') % {player: @player.username }
      PlayerMailer.welcome(@player, generated_password).deliver_later
      redirect_to admin_players_path
    else
      render 'new'
    end
  end

  # GET /admin/players/:username/edit
  def edit
    @player = Player.find_by! username: params[:username]
  end

  # PATCH /admin/players/:username
  def update
    @player = Player.find_by! username: params[:username]

    if @player.update edit_params
      flash[:notice] = t('player.update') % {player: @player.username }
      redirect_to admin_player_path(@player)
    else
      render 'edit'
    end
  end

  # DELETE /admin/players/:username
  def destroy
    @player = Player.find_by! username: params[:username]
    @player.destroy

    flash[:notice] = t('player.destroy') % {player: @player.username }
    redirect_to admin_players_path
  end

  private

    def auth_params
      params.require(:player).permit(:first_name, :last_name, :email)
    end

    def edit_params
      params.require(:player).permit(
        :username, :first_name, :last_name, :email,
        :is_admin
      )
    end

end
