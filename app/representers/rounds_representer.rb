class RoundsRepresenter
  def initialize(rounds)
    @rounds = rounds
  end

  def as_json(_ = {})
    @rounds.map do |round|
      RoundRepresenter.new(round)
    end
  end
end
