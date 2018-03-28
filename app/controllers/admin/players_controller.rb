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
      player.first_name = player_params[:first_name]
      player.last_name = player_params[:last_name]
      player.email = player_params[:email]
      player.password = generated_password
    end

    if @player.save
      flash[:notice] = 'Created a new player.'
      PlayerMailer.welcome(@player, generated_password).deliver_later
      redirect_to admin_players_path
    else
      render 'new'
    end
  end

  def edit
  end

  private

    def player_params
      params.require(:player).permit(:first_name, :last_name, :email)
    end

end
