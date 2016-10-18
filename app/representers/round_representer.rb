class RoundRepresenter
  def initialize(round)
    @round = round
  end

  def as_json(_ = {})
    {
      round_number: @round.round_number,
      tournament: TournamentRepresenter.new(@round.tournament),
    }
  end
end
