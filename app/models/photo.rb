class Photo < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :image

  belongs_to :user

  mount_uploader :image, ImageUploader
  
  scope :overview,  order('id desc')
  scope :previous,  lambda {|current| where('id > ?', current.id) }
  scope :next,      lambda {|current| where('id < ?', current.id) }
end
