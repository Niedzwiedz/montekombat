require "rails_helper"

RSpec.describe Team do
  let(:user) { build(:user, username: "somename") }
  let(:team) { build(:team, name: "somename") }
  let(:match) { build(:match) }
  context "with valid attributes" do
    before do
      team.users << user
    end
    context "has unique name" do
      before do
        create(:team, name: "somename")
      end
      it { expect(team).not_to be_valid }
    end

    context "has unique players" do
      before do
        team.users << create(:user, username: "bettername")
      end
      it { expect(team).to be_valid }
    end
  end

  describe "with invalid attributes" do
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
