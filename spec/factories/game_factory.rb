FactoryGirl.define do
  factory :game do
    name { Faker::Name.title }
  end
end
