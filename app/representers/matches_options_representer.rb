class MatchesOptionsRepresenter
  def initialize(statuses, match_types)
    @statuses = statuses
    @match_types = match_types
  end

  def as_json(_ = {})
    {
      statuses: @statuses,
      match_types: @match_types,
    }
  end
end
