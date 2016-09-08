FactoryGirl.define do
  factory :game do
    name { Faker::Name.title }
    game_picture { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "support", "images", "bear.jpg")) }
  end
end
