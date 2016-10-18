class MatchesRepresenter
  def initialize(matches)
    @matches = matches
  end

  def as_json(_ = {})
    @matches.map do |match|
      MatchRepresenter.new(match)
    end
  end
end
