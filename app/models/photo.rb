class Photo < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :image

  belongs_to :user

  mount_uploader :image, ImageUploader
  
  scope :overview,  order('created_at desc')
  scope :previous,  lambda {|current| where('created_at > ?', current.created_at) }
  scope :next,      lambda {|current| where('created_at < ?', current.created_at) }
end
