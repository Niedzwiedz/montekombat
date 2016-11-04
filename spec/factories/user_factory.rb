FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    password "aaaaaa"
    password_confirmation "aaaaaa"
    account_type "normal"

    trait :admin do
      account_type "admin"
    end
  end
end
