class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @users = User.order('created_at desc').all
  end
  
end
