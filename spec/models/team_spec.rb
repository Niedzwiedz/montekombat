require "rails_helper"

RSpec.describe Team do
  let(:team) { build(:team, name: "somename") }
  let(:user) { build(:user, username: "somename") }
  context "when it's valid" do
    it "has unique name" do
      expect(team.name).to be_present
    end

    it "has unique players" do
      team.users << user
      team.users << create(:user, username: "bettername")
      expect(team).to be_valid
    end

    it "can participe in multiple matches" do
      team.matches << create(:match)
      team.matches << build(:match)
      expect(team).to be_valid
    end
  end

  context "when it's invalid" do
    it "doesn't have unique name" do
      create(:team, name: "somename")
      expect(team).not_to be_valid
    end

    it "player is duplicated" do
      team.users << user
      team.users << user
      expect(team).not_to be_valid
    end
  end
end
