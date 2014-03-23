class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @albums = Album.overview.page(params[:page]).per(params[:per_page] || 50)
  end

end
