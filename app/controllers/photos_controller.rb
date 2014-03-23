class PhotosController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:upload_from_email, :upload, :show]

  def show
    scoped = Photo.scoped

    if params[:album_id].present?
      @album = Album.find(params[:album_id])
      scoped = @album.photos
    end

    if @album.present? && !@album.public
      authenticate_user!
      load_and_authorize_resource
    else
      @photo = scoped.find(params[:id])
    end

    @prev = scoped.overview.previous(@photo).last
    @next = scoped.overview.next(@photo).first
  end

  def new
    @album          = Album.find(params[:album_id]) if params[:album_id].present?
    @form_action    = @album.present? ? upload_album_photos_path(@album) : upload_photos_path
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
        photo = current_user.photos.create!(image: file, album_id: params[:album_id])
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

  def upload_from_email
    logger.fatal params[:mandrill_events]

    head :ok
  end

  def destroy
    if @photo.present? and @photo.destroy
      redirect_to @photo.album.presence || root_path
    end
  end
end
