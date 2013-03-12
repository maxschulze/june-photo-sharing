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

When(/^I click on "(.*?)" in the main navigation$/) do |link|
  within('nav#main') do
    click_link link
  end
end

Then(/^I should be on the people overview page$/) do
  page.should have_content("People")
end

When(/^I click on "(.*?)"$/) do |link|
  click_link link
end