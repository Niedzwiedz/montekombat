require "rails_helper"

RSpec.describe Match do
  let(:user) { create(:user) }
  let(:match) { build(:match) }
  context "with valid attributes" do
    it "" do
      expect(match).to be_valid
    end

    context "doesn't have same team member in two of the fighting teams" do
      before do
        match.team_1.users << user
        match.team_2.users << build(:user)
      end
      it { expect(match).to be_valid }
    end
  end

  describe "with valid attributes" do
    context "points for team 1 is not present" do
      before do
        match.points_for_team1 = nil
      end
      it { expect(match).not_to be_valid }
    end

    context "points for team 2 is not present" do
      before do
        match.points_for_team2 = nil
      end
      it { expect(match).not_to be_valid }
    end

    context "team 1 is not present" do
      before do
        match.team_1 = nil
      end
      it { expect(match).not_to be_valid }
    end

    context "team 2 is not present" do
      before do
        match.team_2 = nil
      end
      it { expect(match).not_to be_valid }
    end

    context "has same team member in two of the fighting teams" do
      before do
        match.team_1.users << user
        match.team_2.users << user
      end
      it { expect(match).not_to be_valid }
    end

    context "there is an empty team" # do
    #   before do
    #     match.team_1.users.clear
    #   end
    #   it { expect(match).not_to be_valid }
    # end

    context "doesn't have type" do
      before do
        match.match_type = nil
      end
      it { expect(match).not_to be_valid }
    end

    context "doesn't have status" do
      before do
        match.status = nil
      end
      it { expect(match).not_to be_valid }
    end
  end
end
