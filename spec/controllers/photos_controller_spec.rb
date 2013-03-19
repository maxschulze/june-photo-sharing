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
  
  describe "GET /photos/show" do
    
    it "should respond with the matching photo" do
      @photo = create(:photo)
      get :show, :id => @photo.to_param
      
      response.should render_template('photos/show')
      assigns[:photo].id.should == @photo.id
    end
    
    it "should define the next and prev photo" do
      3.times { create(:photo) }
      @photos = Photo.overview.all
      
      get :show, :id => @photos.second.to_param
      
      response.should be_success
      
      assigns[:prev].id.should == @photos.first.id
      assigns[:next].id.should == @photos.last.id
    end
    
  end

end
