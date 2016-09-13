require "rails_helper"

RSpec.describe Match do
  let(:user) { create(:user) }
  let(:match) { build(:match) }
  let(:match2) { build(:match) }
  context "with valid attributes" do
    context "doesn't have same team member in two of the fighting teams" do
      it { expect(match).to be_valid }
    end

    context "same team can participate in multiple matches" do
      before do
        match.team_1.users << build_list(:user, 2)
        match.team_2.users << build_list(:user, 2)
        match2.team_1 = match.team_1
        match2.team_2.users << build(:user)
      end
      it { expect(match).to be_valid }
      it { expect(match2).to be_valid }
    end
  end

  describe "with invalid attributes" do
    before do
      match.team_1.users << user
      match.team_1.users << build(:user)
      match.team_2.users << build_list(:user, 2)
    end
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
        match.team_2.users << user
      end
      it { expect(match).not_to be_valid }
    end
  end
end
