class Mandrill::WebHook::EventDecorator

  # Returns the user record for the subject user (if available)
  def sender
    User.where(email: sender_email).first
  end

end