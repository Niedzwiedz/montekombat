require "rails_helper"

RSpec.describe Match do
  let(:match) do
    build(:match, points_for_team1: 8,
                  points_for_team2: 2)
  end
  let(:user) { create(:user) }
  context "is valid" do
    it "has team_1 points" do
      expect(match.points_for_team1).to eq(8)
    end

    it "has team_2 points" do
      expect(match.points_for_team2).to eq(2)
    end

    it "does have team_1" do
      expect(match.team_1).to be_present
    end

    it "does have team_2" do
      expect(match.team_2).to be_present
    end

    it "doen't have same team member in two of the fighting teams" do
      match.team_1.users << user
      match.team_2.users << build(:user)
      expect(match).to be_valid
    end

    it "has specified type" do
      expect(match.match_type).not_to be(nil)
    end

    it "has status" do
      expect(match.status).not_to be(nil)
    end
  end

  context "is invalid" do
    it "doesn't have team_1 points" do
      match.points_for_team1 = nil
      expect(match).not_to be_valid
    end
    it "doesn't have team_2 points" do
      match.points_for_team2 = nil
      expect(match).not_to be_valid
    end
    it "doesn't have team_1" do
      match.team_1 = nil
      expect(match).not_to be_valid
    end

    it "doesn't have team_2" do
      match.team_2 = nil
      expect(match).not_to be_valid
    end
    it "has same team member in two of the fighting teams" do
      match.team_1.users << user
      match.team_2.users << user
      expect(match).not_to be_valid
    end

    it "doesn't have type" do
      match.match_type = nil
      expect(match).not_to be_valid
    end

    it "doesn't have status" do
      match.status = nil
      expect(match).not_to be_valid
    end
  end
end
