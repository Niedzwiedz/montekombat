class TournamentRepresenter < BaseRepresenter
  def initialize(tournament)
    @tournament = tournament
  end

  def basic
    {
      title: @tournament.title,
      description: @tournament.description,
      creator: @tournament.creator,
      type: @tournament.tournament_type,
      status: @tournament.status,
      number_of_teams: @tournament.number_of_teams,
      number_of_players_in_team: @tournament.number_of_players_in_team,
      start_date: @tournament.start_date,
    }
  end

  def with_game_and_teams
    basic.merge(
      game: GameRepresenter.new(@tournament.game),
      teams: TeamsRepresenter.new(@tournament.teams),
    )
  end
end
