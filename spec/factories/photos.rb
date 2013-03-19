# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    title "MyString"
    description "MyText"
    image { File.open(Rails.root.join('spec', 'fixtures', 'test.jpg')) }
    user { FactoryGirl.create(:admin_user) }
    
    factory :exif_photo do
      image { File.open(Rails.root.join('spec', 'fixtures', 'test_exif.jpg')) }
    end
  end
end
