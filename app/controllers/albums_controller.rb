class AlbumsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_filter :load_album, only: [:show, :edit, :update, :destroy, :share]
  authorize_resource
  skip_load_and_authorize_resource :only => [:show]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    authenticate_user! unless @album.public
    order     = session[:album_order]   = params[:order].presence || session[:album_order].presence || 'taken'
    @display  = session[:album_display] = params[:display].presence || session[:album_display].presence || 'grid'

    @photos = @album.photos.
      public_send("sort_#{order}").
      page(params[:page]).
      per(params[:per_page] || 50)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.json
  def new
    @album = Album.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = current_user.albums.build(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render json: @album, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def share
    unless @album.public
      redirect_to @album, notice: 'Album needs to be public in order to be shared.'
      return
    end

    respond_to do |format|
      format.html { render }
      format.json { head :no_content }
    end
  end

  private

  def load_album
    @album ||= Album.friendly.find(params[:id])
  end

end
