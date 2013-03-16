class Photo < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :image

  belongs_to :user

  mount_uploader :image, ImageUploader
end
