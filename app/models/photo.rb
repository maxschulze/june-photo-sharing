require 'exifr'

class Photo < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :image

  belongs_to :user

  mount_uploader :image, ImageUploader
  
  scope :overview,  order('taken_at desc')
  scope :previous,  lambda {|current| where('taken_at > ?', current.taken_at) }
  scope :next,      lambda {|current| where('taken_at < ?', current.taken_at) }
  
  before_save :extract_taken_at
  
  private
  
  def extract_taken_at
    return if self.taken_at.present?
    
    exif_file = EXIFR::JPEG.new(image.file.path)
    
    if exif_file.present? and exif_file.exif?
      self.taken_at = exif_file.date_time
    else
      self.taken_at = DateTime.now
    end
  end
  
end
