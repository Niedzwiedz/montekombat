class InitializeTournament
  class << self
    def call(tournament_params, teams_params)
      creator = User.find(tournament_params["creator"])
      tournament_params["creator"] = creator
      tournament = Tournament.new(tournament_params)
      teams = initialize_teams(teams_params, tournament)

      ActiveRecord::Base.transaction do
        tournament.save!
        teams.each do |team|
          team.save!
        end
      end

      return tournament.reload

      rescue => tournament_transaction_error
        return tournament_transaction_error
    end

    private

    def initialize_teams(teams_params, tournament)
      teams = []
      teams_params.map do |team_params|
        team = Team.new(name: team_params[1]["name"], tournament: tournament)
        users = initialize_users(team_params[1]["users"])
        users.each do |user|
          team.users << user
        end
        teams << team
      end
      teams
    end

    def initialize_users(team_users_params)
      users = []
      team_users_params.each do |team_user_params|
        users << User.find(team_user_params["id"])
      end
      users
    end
  end
end
