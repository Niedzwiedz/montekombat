require 'rails_helper'

RSpec.describe Game do
  let(:game) { build(:game, name: "uniquename") }
  context 'When its valid' do
    it 'should have name' do
      expect(game.name).to be_present
    end
  end
  context 'When its invalid' do
    before do
      create(:game, name: "uniquename")
    end
    it 'should have unique name' do
        expect(game.valid?).to eq(false)
    end
  end
end
