# frozen_string_literal: true

# A controller for viewing actions history
class Admin::ActionsController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/actions
  def index
    @actions = Action.order(created_at: :desc).page(params[:page])
  end
end
