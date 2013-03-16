class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @photos = Photo.order('created_at desc').all
  end

end
