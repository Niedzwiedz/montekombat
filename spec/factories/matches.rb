FactoryGirl.define do
  factory :match_controller do |f|
    f.game
    f.team_1 { create :team }
    f.team_2 { create :team }
    f.points_for_team1 { Faker::Number.digit }
    f.points_for_team2 { Faker::Number.digit }
    f.date { Faker::Time.between(DateTime.now - 1, DateTime.now) }
  end
end
