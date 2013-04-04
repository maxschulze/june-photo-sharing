class InboxController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  
  def handle_inbound(event_payload)
    Photo.create_from_inbound_mail(event_payload)
  end
end
