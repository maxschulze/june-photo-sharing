class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protected
  
  def authenticate_inviter!
    if can?(:manage, User)
      true
    else
      raise CanCan::AccessDenied.new("You don't have permission to send invites.")
    end
  end
end
