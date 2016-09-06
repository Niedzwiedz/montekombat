require 'rails_helper'

RSpec.describe Match do
  let(:match) { build(:match, points_for_team1: 8,
                              points_for_team2: 2) }
  context 'is valid' do
    it 'has team_1 points' do
      expect(match.points_for_team1).to eq(8)
    end

    it 'has team_2 points' do 
      expect(match.points_for_team2).to eq(2)
    end

    it 'has no same team member in two of the fighting teams'
  end

  context 'is invalid' do
    it "doesn't have team_1 points" do
      match.points_for_team1 = nil
      expect(match).to_not be_valid
    end
    it "doesn't have team_2 points" do
      match.points_for_team2 = nil
      expect(match).to_not be_valid
    end
    it "doesn't have team_1" do
      match.team_1 = nil
      expect(match).to_not be_valid
    end

    it "doesn't have team_2" do
      match.team_2 = nil
      expect(match).to_not be_valid
    end

  end
end
