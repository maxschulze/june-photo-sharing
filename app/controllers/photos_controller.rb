class PhotosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
  end

  def upload
    @response = []

    if params[:files].present?
      params[:files].each do |file|
        photo = current_user.photos.create!(:image => file)
        @response << {
          name: file.original_filename,
          size: File.size(file.path),
          url: photo.image.url,
          thumbnail_url: photo.image.thumb.url,
          delete_url: photo_path(photo),
          delete_type: "DELETE"
        }
      end
    end

    render json: { :files => @response }
  end
end
