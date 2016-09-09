require "rails_helper"

RSpec.describe Team do
  let(:team) { build(:team, name: "somename") }
  let(:user) { build(:user, username: "somename") }
  context "When it's valid" do
    it "has unique name" do
      expect(team.name).to be_present
    end

    context "has unique players" do
      before do
        team.users << user
        team.users << create(:user, username: "bettername")
      end
      it { expect(team).to be_valid }
    end

    context "can participe in multiple matches" do
      before do
        team.matches << create(:match)
        team.matches << build(:match)
      end
      it { expect(team).to be_valid }
    end
  end

  describe "When it's invalid" do
    context "doesn't have unique name" do
      before do
        create(:team, name: "somename")
      end
      it { expect(team).not_to be_valid }
    end

    context "player is duplicated" do
      before do
        team.users << user
        team.users << user
      end
      it { expect(team).not_to be_valid }
    end
  end
end
