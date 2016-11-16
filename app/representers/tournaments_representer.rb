class TournamentsRepresenter
  def initialize(tournaments)
    @tournaments = tournaments
  end

  def as_json(_ = {})
    @tournaments.map do |tournament|
      TournamentRepresenter.new(tournament)
    end
  end
end
