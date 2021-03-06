class TeamsRepresenter < BaseRepresenter
  def initialize(teams)
    @teams = teams
  end

  def basic
    @teams.map do |team|
      TeamRepresenter.new(team).basic
    end
  end

  def with_users
    @teams.map do |team|
      TeamRepresenter.new(team).with_users
    end
  end
end
