# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'standard-dev'
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '55a97ec797098452866b63ce031c5b82'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  
  private
  
  @admin = "admin"
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_user
    unless current_user
      store_location
      flash[:error] = "You must be logged in to access this page!"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:error] = "You must be logged out to access this page!"
      redirect_to account_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  ##################
  
  def require_admin
    if current_user 
      unless is_admin
        store_location
        flash[:error] = "You have insufficent rights " +  current_user_session.user.login.to_s + "!"
        redirect_to extensions_url
        return false
      end
    else
      store_location
      flash[:notice] = "You must be logged in to access this page!"
      redirect_to extensions_url
      return false
    end
  end 
  
  def is_admin
    result = false
    current_user_session.user.roles.each do |role|
      if role.name.to_s.eql?("admin") || current_user_session.user.login.to_s.eql?("nikistheadmin")
        result = true
      end
    end  
    result
  end
  
end
