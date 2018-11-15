# frozen_string_literal: true

# A controller for managing tickets in the admin panel
class Admin::TicketsController < ApplicationController
  layout 'admin'
  respond_to :js
  before_action :authenticate_player!
  before_action :require_admin

  PLAYER_TICKET_ATTRIBUTES = %i[id first_name last_name username tickets].freeze

  # GET /admin/tickets
  def index; end

  # GET /admin/players/:player_username/tickets
  def show
    @player = Player.find_by!(username: params[:player_username])
    render json: @player.as_json(only: PLAYER_TICKET_ATTRIBUTES)
    respond_to :json
  end

  # PATCH|PUT /admin/players/:player_username/tickets
  def update; end
end
