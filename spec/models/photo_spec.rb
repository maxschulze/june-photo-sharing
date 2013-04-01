require 'spec_helper'

describe Photo do
  describe "Factory" do
    it { build(:photo).should be_valid }
  end

  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Validations" do
    # it { should validate_presence_of(:attribute) }
  end
  
  describe "Upload Image" do
    it "should upload a new image" do  
      lambda { @photo = create(:photo) }.should_not raise_error
      @photo.image.should be_present
    end
    
    it "should store the date and time when the photo was taken" do
      @photo = create(:exif_photo)
      @photo.taken_at.should be_present
    end
  end
end
