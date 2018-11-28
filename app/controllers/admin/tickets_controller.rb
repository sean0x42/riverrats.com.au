# frozen_string_literal: true

# A controller for managing tickets in the admin panel
class Admin::TicketsController < ApplicationController
  layout 'admin'
  respond_to :js
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/players/:player_username/tickets
  def edit
    @player = Player.find_by!(username: params[:player_username])
  end

  # PATCH|PUT /admin/players/:player_username/tickets
  def update
    tickets = params[:tickets].to_i
    @player = Player.find_by!(username: params[:player_username])
    @player.tickets += tickets
    @player.save
    record_action(:ticket, 'tickets.update',
                  tickets: tickets, player: @player.username)
    redirect_to admin_players_path, notice: t('admin.tickets.update.flash')
  end
end
