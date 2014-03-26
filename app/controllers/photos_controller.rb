class PhotosController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:upload_from_email, :upload, :show]

  def show
    @scoped = Photo.scoped

    load_album

    @photo = @scoped.find(params[:id])

    if @album.blank? || (@album.present? && !@album.public)
      authenticate_user!
      authorize!('show', @photo)
    end

    order = session[:album_order] = params[:order].presence || session[:album_order].presence || 'taken'

    @scoped = @scoped.
      public_send("sort_#{order}")

    @prev = @scoped.public_send("#{order}_previous", @photo).last
    @next = @scoped.public_send("#{order}_next", @photo).first
  end

  def load_album
    if params[:album_id].present?
      @album = Album.friendly.find(params[:album_id])
      @scoped = @album.photos
    end
  end

  def new
    @album          = Album.friendly.find(params[:album_id]) if params[:album_id].present?
    @form_action    = @album.present? ? upload_album_photos_path(@album) : upload_photos_path
  end

  def update
    load_album

    if @photo.update_attributes(params[:photo])
      redirect_to([@album, @photo], :notice => "Photo has been saved successfully.")
    else
      render :action => "show"
    end
  end

  def upload
    @response = []
    @album = Album.friendly.find(params[:album_id])

    if params[:files].present?
      params[:files].each do |file|
        photo = current_user.photos.create!(image: file, album_id: @album.id)
        url   = @album.present? ? album_photo_path(@album, photo) : photo_path(photo)
        @response << {
          name: file.original_filename,
          size: File.size(file.path),
          url: url,
          thumbnail_url: photo.image.thumb.url,
          delete_url: url,
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
