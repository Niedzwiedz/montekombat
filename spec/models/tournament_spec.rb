require "rails_helper"

RSpec.describe Tournament do

  context "with valid attributes" do
    let(:tournament) { build(:tournament, :with_5_teams) }
    it { expect(tournament).to be_valid }
    # status and type validation test
    it { expect(tournament.open?).to be(true) }
    it { expect(tournament.deathmatch?).to be(true) }

    context "number of teams does not exceed specified value" do
      it { expect(tournament.teams.size <= tournament.number_of_teams).to eq(true) }
    end

    context "number of players in team does not exceed specified value" do
      it { expect(tournament).to be_valid }
    end

    context "#empty_slots returns number of empty slots" do
      before do
        build(:tournament, number_of_teams: 10)
        all_slots = tournament.number_of_teams * tournament.number_of_players_in_team
        slots_taken = tournament.teams.size * 3
        @tournament_empty_slots = all_slots - slots_taken
      end
      it { expect(tournament.empty_slots).to eq(@tournament_empty_slots) }
    end
  end

  context "with invalid attributes" do
    context "without title" do
      let(:tournament) { build(:tournament, :without_title) }
      it { expect(tournament).not_to be_valid }
    end

    context "without game" do
      let(:tournament) { build(:tournament, :without_game) }
      it { expect(tournament).not_to be_valid }
    end

    context "without owner" do
      let(:tournament) { build(:tournament, :without_owner) }
      it { expect(tournament).not_to be_valid }
    end

    context "without teams" do
      let(:tournament) { build(:tournament, :with_5_teams, number_of_teams: nil) }
      it { expect(tournament).not_to be_valid }
    end

    context "without number of players in teams" do
      let(:tournament) { build(:tournament, :with_5_teams, number_of_players_in_team: nil) }
      it { expect(tournament).not_to be_valid }
    end

    context "number of teams in tournament exceeds specified value" do
      let(:tournament) { build(:tournament, :with_5_teams, number_of_teams: 4) }
      it { expect(tournament).not_to be_valid }
    end

    context "number of players in teams exceeds specified value" do
      let(:tournament) { build(:tournament, :with_5_teams, number_of_players_in_team: 2) }
      it { expect(tournament).not_to be_valid }
    end
  end
end
