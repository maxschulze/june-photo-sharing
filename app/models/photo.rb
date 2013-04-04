require 'mandrill/webhook/event_decorator'

class Photo < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :image, :taken_at

  belongs_to :user

  mount_uploader :image, ImageUploader
  
  scope :overview,  order('taken_at desc')
  scope :previous,  lambda {|current| where('taken_at > ?', current.taken_at) }
  scope :next,      lambda {|current| where('taken_at < ?', current.taken_at) }
  
  after_create :extract_taken_at
  
  def self.create_from_inbound_mail(payload)
    # security check
    return false if payload.sender.blank?
    
    payload.attachments.each do |attachment|
      photo = Photo.new({
        title: payload.subject
      })
      
      photo.image = attachment.decoded_content
      photo.save!
    end
    
    true
  end
  
  private
  
  def extract_taken_at
    return if self.taken_at.present?
    return if image.blank?
    
    if date_taken = image.get_exif("DateTimeOriginal")
      date_pieces = date_taken.scan(/(\d{4}):(\d{2}):(\d{2}) (\d{2}):(\d{2}):(\d{2})/).first
      self.taken_at = 
        "#{date_pieces[0]}-#{date_pieces[1]}-#{date_pieces[2]} #{date_pieces[3]}:#{date_pieces[4]}:#{date_pieces[5]}"
    else
      self.taken_at = DateTime.now
    end
    
    self.save
  end
  
end
