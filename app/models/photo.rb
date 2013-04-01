class Photo < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :image, :taken_at

  belongs_to :user

  mount_uploader :image, ImageUploader
  
  scope :overview,  order('taken_at asc')
  scope :previous,  lambda {|current| where('taken_at < ?', current.taken_at) }
  scope :next,      lambda {|current| where('taken_at > ?', current.taken_at) }
  
  after_create :extract_taken_at
  
  private
  
  def extract_taken_at
    return if self.taken_at.present?
    
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
