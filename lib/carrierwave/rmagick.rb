#config/initializers/carrierwave.rb
module CarrierWave
  module RMagick

    # Rotates the image based on the EXIF Orientation
    def fix_exif_rotation
      manipulate! do |img|
        img.auto_orient!
        img = yield(img) if block_given?
        img
      end
    end

    # Strips out all embedded information from the image
    def strip
      manipulate! do |img|
        img.strip!
        img = yield(img) if block_given?
        img
      end
    end

    # Reduces the quality of the image to the percentage given
    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage }
        img = yield(img) if block_given?
        img
      end
    end

    def resize_to_fill_if_larger(width, height, gravity=::Magick::CenterGravity)
      geometry = get_geometry
      if geometry.first>width && geometry.last > height
        manipulate! do |img|
          img.crop_resized!(width, height, gravity)
          img = yield(img) if block_given?
          img
        end
      end
    end

    def get_geometry
      img = ::Magick::Image::read(current_path).first
      geometry = [ img.columns, img.rows ]
    end

    module ClassMethods
      def resize_to_fill_if_larger(width, height, gravity=::Magick::CenterGravity)
        process :resize_to_fill_if_larger => [width, height]
      end
    end

  end
end