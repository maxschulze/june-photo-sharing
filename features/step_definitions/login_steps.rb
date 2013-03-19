VALID_PASSWORD = 'cucumber123'

Given(/^I am signed in as an ([a-z]+)$/) do |type|
  user_type = if type == 'admin'
    :admin_user
  else
    :user
  end
  
  @current_user = create(user_type, :password => VALID_PASSWORD, :password_confirmation => VALID_PASSWORD)
  visit('/users/sign_in')
  fill_in 'user_email', :with => @current_user.email
  fill_in 'user_password', :with => VALID_PASSWORD
  click_button 'Sign in'
end