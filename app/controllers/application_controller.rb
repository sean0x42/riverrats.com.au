class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  
  def require_admin
    if current_player.email.nil?
      flash[:errors] = Struct::Flash.new t('errors.missing_admin_email.title'), t('errors.missing_admin_email.description')
      redirect_to root_path
    elsif !current_player.admin? && !current_player.developer?
      flash[:errors] = Struct::Flash.new t('errors.insufficient_permission.title'), t('errors.insufficient_permission.description')
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(_resource)
    root_path
  end
end
