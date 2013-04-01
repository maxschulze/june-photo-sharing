class PhotosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    @prev = Photo.overview.previous(@photo).first
    @next = Photo.overview.next(@photo).first
  end

  def new
  end
  
  def update
    if @photo.update_attributes(params[:photo])
      redirect_to(@photo, :notice => "Photo has been saved successfully.")
    else
      render :action => "show"
    end
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
  
  def destroy
    if @photo.present? and @photo.destroy
      redirect_to root_path
    end
  end
end
