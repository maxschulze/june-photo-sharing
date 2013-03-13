require 'spec_helper'

describe UsersController do
  login_admin
  
  describe "GET /users" do
    
    it "should respond with a list of all users" do
      user = create(:user)
      
      get :index
      response.should be_success
      assigns[:users].should be_present
      assigns[:users].should include(user)
      assigns[:users].should include(subject.current_user)
    end
    
  end
end
