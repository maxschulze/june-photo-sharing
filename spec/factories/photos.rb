# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    title "MyString"
    description "MyText"
    user { FactoryGirl.create(:admin_user) }
  end
end
