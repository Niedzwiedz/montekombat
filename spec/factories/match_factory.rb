FactoryGirl.define do
  factory :match do
    game { create :game }
    team_1 { create :team }
    team_2 { create :team }
    points_for_team1 { Faker::Number.digit }
    points_for_team2 { Faker::Number.digit }
    date { Faker::Time.between(DateTime.now - 1, DateTime.now) }
  end
  factory :invalid_match, parent: :match do |f|
    f.team_1 nil
  end
end
