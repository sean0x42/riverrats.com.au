# frozen_string_literal: true

# Base controller
class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  def pundit_user
    current_player
  end

  private

  def require_admin
    message = if current_player.email.nil?
                t('errors.missing_admin_email.flash')
              elsif !current_player.admin? && !current_player.developer?
                t('errors.insufficient_permission.flash')
              end

    redirect_to root_path, notice: message unless message.nil?
  end

  def after_sign_in_path_for(_resource)
    root_path
  end

  def record_action(action, translation, value_hash = {})
    Action.create(
      player: current_player, action: action,
      description: format(t("admin.#{translation}.action"), value_hash)
    )
  end
end
