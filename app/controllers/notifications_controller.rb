# frozen_string_literal: true

# A controller for notifications
class NotificationsController < ApplicationController
  # GET /notifications
  def index
    @notifications = if request.format.html?
                       current_player.notifications.page(params[:page])
                     else
                       current_player.notifications.limit(15)
                     end
  end
end
