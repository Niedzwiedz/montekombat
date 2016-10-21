class RoundRepresenter
  def initialize(round)
    @round = round
  end

  def as_json(_ = {})
    {
      round_number: @round.round_number,
      matches: MatchesRepresenter.new(@round.matches),
    }
  end
end
