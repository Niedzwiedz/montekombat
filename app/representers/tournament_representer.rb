class TournamentRepresenter
  def initialize(tournament)
    @tournament = tournament
  end

  def as_json(_ = {})
    {
      title: @tournament.title,
      creator: @tournament.creator,
      type: @tournament.tournament_type,
      status: @tournament.status,
      number_of_teams: @tournament.number_of_teams,
      number_of_players_in_team: @tournament.number_of_players_in_team,
      start_date: @tournament.start_date,
      game: GameRepresenter.new(@tournament.game),
      teams: TeamsRepresenter.new(@tournament.teams),
    }
  end
end
