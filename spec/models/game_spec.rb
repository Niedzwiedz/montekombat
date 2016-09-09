require "rails_helper"

RSpec.describe Game do
  let(:game) { build(:game) }
  context "When it's valid" do
    it "has name" do
      expect(game.name).to be_present
    end

    it "has picture" do
      expect(game.game_picture).to be_present
    end
  end
  context "When it's invalid" do
    let(:game) { build(:game, name: "uniquename") }
    context "does not have unique name" do
      before do
        create(:game, name: "uniquename")
      end
      it { expect(game.valid?).to eq(false) }
    end
  end
end
