# frozen_string_literal: true

# A controller for notifications
class NotificationsController < ApplicationController
  # GET /notifications
  def index
    @notifications = if request.format.html?
                       current_player.notifications.page(params[:page])
                     else
                       current_player.unread_notifications.limit(15)
                     end
  end

  # DELETE /notifications/:id
  def destroy
    @notification = current_player.notifications.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.js
    end
  end

  # PATCH/PUT /notifications/:id/mark-read
  def mark_read
    @notification = current_player.notifications.find(params[:id])
    @notification.update(read: true)

    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.js
    end
  end

  # PATCH/PUT /notifications
  def clear
    current_player.notifications.update(read: true)
    head :ok, content_type: 'text/html'
  end
end
