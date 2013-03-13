require 'spec_helper'

describe UsersController do
  login_admin

  describe "GET /users" do

    it "should respond with a list of all users" do
      user = create(:user)

      get :index
      response.should be_success
      assigns[:users].should be_present
      assigns[:users].should include(user)
      assigns[:users].should include(subject.current_user)
    end

  end

  describe "GET /users/:id/edit" do
    before do
      @user = create(:user)
    end

    it "should respond with the edit form" do
      get :edit, :id => @user.to_param

      response.should be_success
      response.should render_template('users/edit')
      assigns[:user].id.should == @user.id
    end
  end

  describe "PUT /users/:id" do
    before do
      @user = create(:user)
      @valid_changes = { user: { first_name: 'Max' } }
      @invalid_changes = { user: { first_name: '' } }
    end

    it "should redirect to index after successful save" do
      put :update, @valid_changes.merge(:id => @user.to_param)

      response.should be_redirect
      response.should redirect_to(users_path)
    end

    it "should render the form again on error" do
      put :update, @invalid_changes.merge(:id => @user.to_param)

      response.should be_success
      response.should render_template('users/edit')
      assigns[:user].errors.should be_present
    end
  end

  describe "DELETE /users/:id" do
    before do
      @user = create(:user)
    end

    it "should redirect to index after successful destroy" do
      delete :destroy, :id => @user.to_param

      response.should be_redirect
      response.should redirect_to(users_path)
    end

  end

end
