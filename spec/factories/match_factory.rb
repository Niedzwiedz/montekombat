FactoryGirl.define do
  factory :match do
    game
    association :team_1_id, factory: team
    association :team_2_id, factory: team
    points_for_team1 Faker::Number.digit
    points_for_team2 Faker::Number.digit
    date Faker::Time.between(DateTime.now - 1, DateTime.now)
  end
end
