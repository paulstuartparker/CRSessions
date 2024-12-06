class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_admin_user!
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this area"
      redirect_to root_path
    end
  end
end
