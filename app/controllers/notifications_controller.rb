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

  # PATCH/PUT /notifications/:notification_id/mark-read
  def mark_read
    @notification = current_player.notifications.find(params[:notification_id])
    @notification.update(read: !@notification.read)

    respond_to do |format|
      format.html { redirect_to notifications_path }
      format.js { render 'success' }
    end
  end

  # PATCH/PUT /notifications
  def clear
    # rubocop:disable Rails/SkipsModelValidations
    current_player.notifications.update_all(read: true)
    # rubocop:enable Rails/SkipsModelValidations
    head :ok, content_type: 'text/html'
  end
end
