class InitializeTournament
  class << self
    def call(tournament_params, teams_params)
      tournament = Tournament.new(**tournament_params)
      teams = initialize_teams(teams_params["teams"], tournament)

      ActiveRecord::Base.transaction do
        tournament.save!
        teams.each do |team|
          team.save!
        end
      end
      return tournament

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
      team_users_params.map do |team_user_params|
        users << User.find(team_user_params[1]["id"])
      end
      users
    end
  end
end
