# frozen_string_literal: true

require 'flash_message'

# A controller for mail in the admins cope
class Admin::MailController < ApplicationController
  layout 'admin'
  before_action :authenticate_player!
  before_action :require_admin

  # GET /admin/mail
  def index
    respond_to :js
  end

  # POST /admin/mail/players.csv
  def generate
    target = params.key?(:target) ? params[:target] : 'promotional'
    options = {}

    if target == 'promotional'
      options[:notify_promotional] = true
    elsif target == 'event'
      options[:notify_events] = true
    end

    respond_to do |format|
      format.csv { send_data Player.where(options).to_csv }
    end
  end
end
