class InitializeTournament
  class << self
    def call(tournament_params, teams_params, owner)
      tournament_params[:creator] = owner
      tournament = Tournament.new(tournament_params)
      initialize_teams(teams_params["team_list"], tournament)
      tournament.save!
      return tournament.reload
    end

    private

    def initialize_teams(teams_params, tournament)
      teams_params.map do |team_params|
        team = tournament.teams.build(name: Team.new(name: team_params[1]["name"]).name, tournament: tournament)
        initialize_users(team_params[1]["users"], team, tournament)
      end
    end

    def initialize_users(team_users_params, team, tournament)
      team_users_params.map do |team_user_params|
        user_id = User.find(team_user_params[1]["id"]).id
        team.team_users.build(user_id: user_id)
        tournament.tournament_users.build(user_id: user_id)
      end
    end
  end
end
