# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    email
    password              'test123456'
    password_confirmation 'test123456'
    first_name            'Tester'
    last_name             'tester'

    trait :admin do
      role 'admin'
    end

    factory :admin_user,    traits: [:admin]
  end

end
