FactoryGirl.define do
  factory :team do
    name { Faker::Team.name }
    tournament
    after(:build) do |team|
      3.times do
        team.users << create(:user)
      end
    end
  end
end
