class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.order('created_at desc').all
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "User has been saved."
      redirect_to users_path
    else
      render action: 'edit'
    end
  end
  
  def destroy
    if @user.destroy
      flash[:notice] = "User has been destroyed."
      redirect_to users_path
    else
      flash[:alert] = "Could not destroy the user."
      redirect_to users_path
    end
  end

end
