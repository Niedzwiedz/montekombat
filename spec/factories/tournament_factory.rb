FactoryGirl.define do
  factory :tournament do
    game { create :game }
    creator { create :user }
    title { Faker::Pokemon.name }
    number_of_teams 6
    number_of_players_in_team 6
    start_date { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    tournament_picture { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "support", "images", "bear.jpg")) }

    trait :with_5_teams do
      number_of_teams 5
      number_of_players_in_team 3
      after(:build) do |tournament|
        5.times do
          tournament.teams << create(:team)
        end
      end
    end

    trait :started do
      status "started"
    end

    trait :ended do
      status "ended"
    end

    trait :without_title do
      title nil
    end

    trait :without_game do
      game nil
    end

    trait :without_owner do
      creator nil
    end
  end
end
