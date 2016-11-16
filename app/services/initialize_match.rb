class InitializeMatch
  class << self
    def call(match_params, team_1_params, team_2_params, team1_users_params, team2_users_params)
      creator = User.find(match_params["creator"])
      match_params["creator"] = creator
      match = Match.new(match_params)
      match.team_1 = initialize_team(team_1_params, team1_users_params)
      match.team_2 = initialize_team(team_2_params, team2_users_params)

      match.save!

      return match.reload

      rescue => match_error
        return match_error
    end

    def initialize_team(team_params, users_params)
      team = Team.new(name: team_params["name"])
      users = initialize_users(users_params)
      users.each do |user|
        team.users << user
      end
      team
    end

    def initialize_users(users_params)
      users = []
      users_params.each do |index|
        users << User.find(users_params[index]["id"])
      end
      users
    end
  end
end
