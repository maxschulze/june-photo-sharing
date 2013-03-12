Given(/^I am signed in as an admin$/) do
  @admin = create(:admin_user, :password => VALID_PASSWORD, :password_confirmation => VALID_PASSWORD)
  visit('/users/sign_in')
  fill_in 'user_email', :with => @admin.email
  fill_in 'user_password', :with => VALID_PASSWORD
  click_button 'Sign in'
end

When(/^I go to the start page$/) do
  visit('/')
end