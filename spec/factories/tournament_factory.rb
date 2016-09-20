FactoryGirl.define do
  factory :tournament do
    game { create :game }
    creator { create :user }
    title { Faker::Pokemon.name }
    number_of_teams { Faker::Number.digit }
    number_of_players_in_team { Faker::Number.digit }
    start_date { Faker::Time.between(DateTime.now - 1, DateTime.now) }
  end

  factory :tournament_teams, parent: :tournament do
    number_of_teams 5
    number_of_players_in_team 3
    after(:build) do |tournament|
      5.times do
        tournament.teams << create(:team)
      end
    end
  end
end
