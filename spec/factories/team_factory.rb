FactoryGirl.define do
  factory :team do
    name { Faker::Team.name }
    after(:build) do |team|
      team.users << create(:user)
    end
  end
end
