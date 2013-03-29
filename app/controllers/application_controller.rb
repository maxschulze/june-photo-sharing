class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :switch_heroku
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protected
  
  def switch_heroku
    if request.url ~= /heroku/
      redirect_to "http://server.maxschulze.com#{request.path}"
      return
    end
  end
  
  def authenticate_inviter!
    if can?(:manage, User)
      current_user
    else
      raise CanCan::AccessDenied.new("You don't have permission to send invites.")
    end
  end
end
