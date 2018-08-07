class Admin::PlayersController < ApplicationController

  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/players
  def index
    all = Player.order(score: :desc)

    if params.has_key? :query
      @players = Player.search params[:query], page: params[:page], per_page: 25
    else
      @players = all.page params[:page]
    end

    @stats = {
      count: all.count,
      new_count: all.where('created_at > ?', Date.today - 30.days).count,
      admin_count: all.where(is_admin: true).count
    }
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
  def create
    generated_password = Devise.friendly_token(8)

    @player = Player.new do |player|
      player.first_name = auth_params[:first_name]
      player.last_name = auth_params[:last_name]
      player.email = auth_params[:email].blank? ? nil : auth_params[:email]
      player.is_admin = auth_params[:is_admin]
      player.password = generated_password
    end

    if @player.save

      # Alert player with flash
      flash[:success] = FlashMessage.new(
        'Success!',
        t('player.create') % {
          player: @player.username,
          link: player_path(@player)
        }
      )

      PlayerMailer.welcome(@player.id, generated_password).deliver_later
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
      # Alert player with flash
      flash[:success] = FlashMessage.new(
        'Success!',
        t('player.update') % {
          player: @player.username,
          link: player_path(@player)
        }
      )
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
    @player = Player.find_by! username: params[:username]
    @player.destroy

    flash[:success] = FlashMessage.new 'Success!', t('player.destroy') % { player: @player.username }
    redirect_to admin_players_path
  end

  private

  def auth_params
    params.require(:player).permit(:first_name, :last_name, :email, :is_admin)
  end

  def edit_params
    if params.has_key? :email && params[:email].blank?
      params[:email] = nil
    end
    params.require(:player).permit(:username, :first_name, :last_name, :email, :is_admin)
  end

  def require_admin
    unless current_player.is_admin
      flash[:success] = FlashMessage.new 'Permission denied', 'You do not have permission to access this page.'
      redirect_to root_path
    end
  end

end
