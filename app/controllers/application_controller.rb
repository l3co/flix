class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :current_user?, :current_user_admin?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    current_user == user
  end

  def current_user_admin?
    current_user&.admin?
  end

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_path, alert: "You must be logged in to access this section."
    end
  end

  def require_admin
    unless current_user&.admin?
      redirect_to events_url, alert: "You must be an admin to access this section."
    end
  end
end
