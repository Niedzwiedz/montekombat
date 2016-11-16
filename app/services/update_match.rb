class UpdateMatch
  class << self
    def call(match)
      assign_winner(match)
      run_deathmatch_generator(match)
      match
    end

    private

    def assign_winner(match)
      if match.finished?
        if match.points_for_team1 > match.points_for_team2
          match.update_attributes(winner: match.team_1)
        else
          match.update_attributes(winner: match.team_2)
        end
      end
    end

    def run_deathmatch_generator(match)
      if match.finished? && match.last_match_in_round?
        match.deathmatch_round_generator
      end
    end
  end
end
