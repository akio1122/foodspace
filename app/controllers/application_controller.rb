class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper ActiveadminSettings

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def access_denied(exception)
    redirect_to admin_posts_path, :alert => exception.message
  end

  def authenticate_active_admin_user!
    authenticate_user!

    return if current_user.role?('developer') || current_user.role?('administrator') || current_user.role?('author')
    # front end users will get bombed out of activeadmin
    # flash[:alert] = "You are not authorized to access this resource!"
    redirect_to root_path
  end
end
