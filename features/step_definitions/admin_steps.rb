INVITE_EMAIL = "june@schulze.com"

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
    click_link link.titleize
  end
end

Then(/^I should be on the people overview page$/) do
  page.should have_content("People")
end

When(/^I click on "(.*?)"$/) do |link|
  click_link link
end

When(/^I click the "(.*?)" button$/) do |link|
  click_button link
end


Then(/^I should see the invite form$/) do
  page.should have_css('form.simple_form.new_user')
end

When(/^I enter the information of the person that I want to invite$/) do
  fill_in 'user_first_name', with: "June"
  fill_in 'user_last_name', with: "Schulze"
  fill_in 'user_email', with: INVITE_EMAIL
end

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content(content)
end

Then(/^I should see the invitation success message/) do
  step %{I should see "An invitation email has been sent to #{INVITE_EMAIL}."}
end

Then(/^the person should have received an invitation email$/) do
  step %{"#{INVITE_EMAIL}" should receive an email}
end

Given(/^I have received an invite$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click the invitation link in the email$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be on the registration page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be personally greeted$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I pick and fill in a valid password$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be on the start page$/) do
  pending # express the regexp above with the code you wish you had
end