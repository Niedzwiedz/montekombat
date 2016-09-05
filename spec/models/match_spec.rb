require 'rails_helper'

RSpec.describe Match do
  it 'should have points for first team' do
    match = FactoryGirl.create(:match)
    expect(match.points_for_team1).to be_a(Integer)
  end

  it 'should have points for second team'
end
