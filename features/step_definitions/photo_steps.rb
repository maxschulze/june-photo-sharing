Given(/^I am on the start page$/) do
  step %{I go to the start page}
end

Then(/^I should see the upload photo form$/) do
  page.should have_css('form.new_photo')
end

When(/^I attach a valid photo file$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I enter valid photo meta data$/) do
  pending # express the regexp above with the code you wish you had
end