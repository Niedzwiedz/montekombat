require 'rails_helper'

RSpec.describe Team do
  let(:team) {build(:team, name: "somename")}
  context "When it's valid" do
    it "has unique name" do
      expect(team.name).to be_present
    end

    it 'has at least one team member'
  end

  context "When it's invalid" do
    it "doesn't have unique name" do
      create(:team, name: "somename")
      expect(team.valid?).to eq(false)
    end

    it "has too long name" do
      team.name = "more-than-66-******************************************************************"
      expect(team).to_not be_valid
    end

    it "has too short name" do
      team.name = "*"
      expect(team).to_not be_valid
    end

    it "has no team members"
  end
end
