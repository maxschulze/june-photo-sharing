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

Given(/^(\d+) photos exist$/) do |count|
  @photos = []
  count.to_i.times do
    @photos << create(:photo)
  end
  
  @photo_count = Photo.count
end

Then(/^I should see an overview of photos$/) do
  page.should have_css('ul.thumbnails li')
  all('ul.thumbnails li').length.should == @photos.count
end

When(/^I click on the first photo$/) do
  all('ul.thumbnails li a').first.click
end

Then(/^I should see a larger version of the photo$/) do
  page.should have_css('img.photo')
end

Given(/^I see (\d+) picture per page on the overview$/) do |amount|
  @params = { :per_page => amount }
end

Then(/^I should see the first photo$/) do
  @photos = Photo.overview.all
  page.should have_css("ul.thumbnails li[data-photo-id=\"#{@photos.first.id}\"]")
end

Then(/^I should see the pagination$/) do
  page.should have_css('nav.pagination')
end

When(/^I select the second page$/) do
  all('nav.pagination li a[rel="next"]').first.click
end

Then(/^I should see the second photo$/) do
  @photos = Photo.overview.all
  page.should have_css("ul.thumbnails li[data-photo-id=\"#{@photos.second.id}\"]")
end

Then(/^the photo should be deleted$/) do
  Photo.count.should == @photo_count - 1
end