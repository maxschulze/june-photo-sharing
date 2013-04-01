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
  
  describe "GET /photos/:id" do
    
    it "should respond with the matching photo" do
      @photo = create(:photo)
      get :show, :id => @photo.to_param
      
      response.should render_template('photos/show')
      assigns[:photo].id.should == @photo.id
    end
    
    it "should define the next and prev photo" do
      3.times {|i| create(:photo, taken_at: i.days.ago) }
      @photos = Photo.overview.all
      
      get :show, :id => @photos.second.to_param
      pp @photos
      response.should be_success
      
      assigns[:prev].id.should == @photos.first.id
      assigns[:next].id.should == @photos.last.id
    end
    
  end
  
  describe "PUT /photos/:id" do
    before do
      @photo = create(:photo)
    end
    
    it "should update the photo with the new attributes" do
      put :update, :id => @photo.to_param, :photo => { title: 'new-title', taken_at: '01/01/2012' }
      
      response.should redirect_to(photo_path(@photo))
      updated = assigns(:photo)
      updated.title.should == 'new-title'
      updated.taken_at.to_date.should == Date.new(2012, 1, 1)
    end
    
    it "should render the show view if an error has happened" do
      Photo.any_instance.stub(:valid?).and_return(false)
      
      put :update, :id => @photo.to_param, :photo => { title: '' }
      
      response.should render_template('photos/show')
      assigns(:photo).should_not be_valid
    end
  end
  
  describe "DELETE /photos/:id" do
    it "should delete a photo" do
      @photo = create :photo
      delete :destroy, :id => @photo.to_param
      
      Photo.count.should == 0
      
      response.should redirect_to(root_path)
    end
    
    it "should return a 404 if the photo was not found" do
      lambda {
        delete :destroy, :id => 'does-not-exist'
      }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end

end
