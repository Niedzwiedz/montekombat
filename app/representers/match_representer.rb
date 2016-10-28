class MatchRepresenter
  def initialize(match)
    @match = match
  end

  def as_json(_ = {})
    if @match.team_1_id != 0 && @match.team_2_id != 0
      {
        date: @match.date,
        status: @match.status,
        match_type: @match.match_type,
        points_for_team1: @match.points_for_team1,
        points_for_team2: @match.points_for_team2,
        game: GameRepresenter.new(@match.game),
        team_1: TeamRepresenter.new(@match.team_1),
        team_2: TeamRepresenter.new(@match.team_2),
      }
    elsif @match.team_1_id == 0
      {
        date: @match.date,
        status: @match.status,
        match_type: @match.match_type,
        points_for_team1: @match.points_for_team1,
        points_for_team2: 0,
        game: GameRepresenter.new(@match.game),
        team_1: { id: 0, name: 'TEAM LEFT', users: [] },
        team_2: TeamRepresenter.new(@match.team_2),
      }
    elsif @match.team_2_id == 0
      {
        date: @match.date,
        status: @match.status,
        match_type: @match.match_type,
        points_for_team1: 0,
        points_for_team2: @match.points_for_team2,
        game: GameRepresenter.new(@match.game),
        team_2: { id: 0, name: 'TEAM LEFT', users: [] },
        team_1: TeamRepresenter.new(@match.team_1),
      }
    end
  end
end
