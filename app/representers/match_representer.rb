class MatchRepresenter
  def initialize(match)
    @match = match
  end

  def as_json(_ = {})
    {
      date: @match.date,
      status: @match.status,
      match_type: @match.match_type,
      round: @match.round,
      points_for_team1: @match.points_for_team1,
      points_for_team2: @match.points_for_team2,
      game: GameRepresenter.new(@match.game),
      team_1: TeamRepresenter.new(@match.team_1),
      team_2: TeamRepresenter.new(@match.team_2),
    }
  end
end
