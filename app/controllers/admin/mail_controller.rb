class Admin::MailController < ApplicationController

  layout 'admin'

  # GET /admin/mail
  def index
  end

  # POST /admin/mail/players.csv
  def show
    target = params.has_key?(:target) ? params[:target] : 'promotional'

    case target
    when 'promotional'
      @players = Player.where notify_promotional: true
    when 'event'
      @players = Player.where notify_events: true
    when 'all'
      @players = Player.all
    else
      render nothing: true, status: 400
    end

    respond_to do |format|
      format.csv { send_data @players.to_csv }
    end
  end

end
