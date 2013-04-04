require 'spec_helper'

describe InboxController do

  describe "Upload a photo via email" do
    
    before(:all) do
      @mandrill_incoming_json = File.read(
        Rails.root.join('spec', 'fixtures', 'mandrill_incoming_email.json')
      )
    end
    
    it "should create a new photo from an incoming email" do
      Photo.should_receive(:create_from_inbound_mail).and_return(true)
      post :create, :mandrill_events => @mandrill_incoming_json
    end
  end

end
