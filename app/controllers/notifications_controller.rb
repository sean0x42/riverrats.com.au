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

  # DELETE /notifications/:id
  def destroy
    @notification = Notification.find params[:id]
    return unless can_modify?(@notification)

    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_path }
    end
  end

  # PATCH/PUT /notifications/:id
  def mark_read
    @notification = Notification.find params[:id]
    return unless can_modify?(@notification)

    @notification.update(read: true)
    respond_to do |format|
      format.html { redirect_to notifications_path }
    end
  end

  private

  # Determines whether the current player can modify the given notification.
  def can_modify?(notification)
    return true if current_player.id == notification.player_id

    render nothing: true, status: :forbidden
    false
  end
end
