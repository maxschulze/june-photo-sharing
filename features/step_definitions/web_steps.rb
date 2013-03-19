When(/^I click on "(.*?)"$/) do |link|
  click_link link
end

When(/^I click the "(.*?)" button$/) do |link|
  click_button link
end

Then(/^I should see "(.*?)"$/) do |content|
  page.should have_content(content)
end

When(/^I go to the start page$/) do
  visit("/?#{(@params || {}).to_query}")
end

Then(/^I should be on the start page$/) do
  page.should have_css("#start")
end

When(/^I click on "(.*?)" in the main navigation$/) do |link|
  within('nav#main') do
    click_link link.titleize
  end
end