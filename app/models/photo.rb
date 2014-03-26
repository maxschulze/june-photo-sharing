# encoding: UTF-8

require 'mandrill/webhook/event_decorator'

class Photo < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :image, :taken_at, :album_id

  belongs_to :user
  belongs_to :album

  mount_uploader :image, ImageUploader

  scope :sort_taken,        -> { order('taken_at asc') }
  scope :sort_created,      -> { order('created_at desc') }
  scope :taken_previous,    lambda { |current| where('taken_at < ?', current.taken_at) }
  scope :taken_next,        lambda { |current| where('taken_at > ?', current.taken_at) }
  scope :created_previous,  lambda { |current| where('created_at > ?', current.created_at) }
  scope :created_next,      lambda { |current| where('created_at < ?', current.created_at) }

  after_create :extract_taken_at

  def self.create_from_inbound_mail(payload)
    # security check
    return false if payload.sender.blank?

    payload.attachments.each do |attachment|
      next unless attachment.content.present? and attachment.type =~ /image/

      photo = Photo.new({
        title: payload.subject
      })
      photo.user = payload.sender

      begin
        file = Tempfile.new('email_upload')
        file.binmode
        file.write attachment.decoded_content
        file.rewind

        uploaded_file = ActionDispatch::Http::UploadedFile.new(
          :tempfile => file,
          :filename => attachment.name,
          :original_filename => attachment.name
        )

        photo.image = uploaded_file
        photo.save!
      ensure
        file.close
        file.unlink
      end
    end

    true
  end

  def taken_at=(date)
    if date.is_a?(String) && date =~ /[\/]{1}/
      logger.fatal "Fixing date"
      logger.fatal "Date #{date}"
      splitted_date = date.split("/")
      date = "#{splitted_date.last}/#{splitted_date.first}/#{splitted_date[1]}"
      write_attribute :taken_at, Date.parse(date)
    else
      logger.fatal "Writing date"
      write_attribute :taken_at, date
    end
  end

  def author_name
    user.full_name
  end

  private

  def extract_taken_at
    return if self.taken_at.present?
    return if image.blank?

    date_taken = image.get_exif("Create Date")
    date_taken ||= image.get_exif("Date/Time Original")
    date_taken ||= image.get_exif("DateTimeOriginal")

    if date_taken.present?
      Rails.logger.fatal "Image was taken at #{date_taken}"

      date_pieces = date_taken.scan(/(\d{4}):(\d{2}):(\d{2}) (\d{2}):(\d{2}):(\d{2})/).first
      self.taken_at =
        "#{date_pieces[0]}-#{date_pieces[1]}-#{date_pieces[2]} #{date_pieces[3]}:#{date_pieces[4]}:#{date_pieces[5]}"
    else
      self.taken_at = DateTime.now
    end

    self.save
  end

end
