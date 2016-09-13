FactoryGirl.define do
  factory :team do
    name { Faker::Team.name }

    factory :team_with_users do
      after(:build) do |team|
        team.users << create(:user)
      end
    end
  end
end
