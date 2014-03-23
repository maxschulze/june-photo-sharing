# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    name "MyString"
    user_id 1
    public false
    slug "MyString"
  end
end
