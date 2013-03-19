Given(/^I am on the start page$/) do
  step %{I go to the start page}
end

Then(/^I should see the upload photo form$/) do
  page.should have_css('form#fileupload')
end

When(/^I attach a valid photo file$/) do
  attach_file("files[]", Rails.root.join('spec/fixtures/test.jpg'))
end

Then(/^I should see the uploads$/) do
  visit('/')
  page.should have_css('.thumbnails li a img')
  all('.thumbnails li a img').count.should == 1
end