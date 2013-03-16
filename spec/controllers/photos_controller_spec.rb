require 'spec_helper'

describe PhotosController do
  login_admin

  describe "GET /photos/new" do

    it "should respond with the new photo template" do
      get :new
      response.should be_success
      response.should render_template('photos/new')
      assigns[:photo].should be_present
      assigns[:photo].should be_new_record
    end

  end

end
