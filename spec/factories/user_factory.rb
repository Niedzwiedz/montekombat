FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    password { Faker::Internet.password(10, 20, true) }
  end
end
