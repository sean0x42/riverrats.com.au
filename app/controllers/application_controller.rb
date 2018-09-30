# frozen_string_literal: true

# Base controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
end
