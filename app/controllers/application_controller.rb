class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  
  def require_admin
    unless current_player.is_admin
      flash[:error] = Struct::Flash.new t('error.insufficient_permission.title'), t('error.insufficient_permission.description')
      redirect_to root_path
    end
  end
end
