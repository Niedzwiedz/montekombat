class TournamentRepresenter
  def initialize(tournament)
    @tournament = tournament
  end

  def as_json(_ = {})
    {
      id: @tournament.id,
      title: @tournament.title,
      description: @tournament.description,
      creator: @tournament.creator,
      type: @tournament.tournament_type,
      status: @tournament.status,
      number_of_teams: @tournament.number_of_teams,
      number_of_players_in_team: @tournament.number_of_players_in_team,
      start_date: @tournament.start_date.strftime("%d/%m/%Y - %H:%M"),
      game: GameRepresenter.new(@tournament.game),
      teams: TeamsRepresenter.new(@tournament.teams),
      rounds: RoundsRepresenter.new(@tournament.rounds),
    }
  end
end
