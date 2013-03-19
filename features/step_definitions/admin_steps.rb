INVITE_EMAIL = "june@schulze.com"

Then(/^I should be on the people overview page$/) do
  page.should have_content("People")
end

Then(/^I should see the invite form$/) do
  page.should have_css('form.simple_form.new_user')
end

When(/^I enter the information of the person that I want to invite$/) do
  fill_in 'user_first_name', with: "June"
  fill_in 'user_last_name', with: "Schulze"
  fill_in 'user_email', with: INVITE_EMAIL
end

Then(/^I should see the invitation success message/) do
  step %{I should see "An invitation email has been sent to #{INVITE_EMAIL}."}
end

Then(/^the person should have received an invitation email$/) do
  step %{"#{INVITE_EMAIL}" should receive an email}
end

Given(/^I have received an invite$/) do
  User.invite!(:email => INVITE_EMAIL, :first_name => "Test", :last_name => "Test")
  step %{"#{INVITE_EMAIL}" should receive an email}
end

When(/^I click the invitation link in the email$/) do
  step %{I open the email}
  step %{I follow "Accept invitation" in the email}
end

Then(/^I should be on the registration page$/) do
  page.should have_content("Please pick your password.")
end

Then(/^I should be personally greeted$/) do
  page.should have_content("Welcome Test Test!")
end

When(/^I pick and fill in a valid password$/) do
  fill_in 'user_password', with: 'test123456'
  fill_in 'user_password_confirmation', with: 'test123456'
end

Given(/^I am on the manage people page$/) do
  visit('/users')
  page.should have_css('table')
end

Given(/^(\d+) people with access exist$/) do |count|
  before = User.count

  count.to_i.times do |i|
    create(:user)
  end

  User.count.should == (before.to_i + count.to_i)
end

When(/^I click on edit for the first person$/) do
  step %{I open the action dropdown for a user}
  page.first('table.table tbody tr').click_link('Edit')
end

Then(/^I should be on the edit page$/) do
  page.should have_css('form.edit_user')
end

When(/^I change the first name$/) do
  fill_in 'user_first_name', with: 'Changed'
end

Then(/^I should be on the manage people page$/) do
  page.should have_css('table.table')
end

Then(/^I should see the new first name$/) do
  page.should have_content('Changed')
end

When(/^I open the action dropdown for a user$/) do
  page.first('table.table tbody tr').click_link('Action')
end

When(/^I click on delete for the first person$/) do
  @user_count = User.count
  
  step %{I open the action dropdown for a user}
  element = page.first('table.table tbody tr')
  element.click_link('Delete')
end

When(/^I press ok in the confirmation message$/) do
  page.driver.browser.switch_to.alert.accept unless Capybara.javascript_driver == :poltergeist
end

Then(/^the person should be deleted$/) do
  User.count.should == @user_count - 1
end