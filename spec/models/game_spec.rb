require "rails_helper"

RSpec.describe Game do
  let(:game) { build(:game) }
  context "When its valid" do
    it "has name" do
      byebug
      expect(game.name).to be_present
    end

    it { expect(game.game_picture ).not_to be_present }
  end
  context "When its invalid" do
    let(:game) { build(:game, name: "uniquename") }
    before do
      create(:game, name: "uniquename")
    end
    it "does not have unique name" do
      expect(game.valid?).to eq(false)
    end
  end
end
