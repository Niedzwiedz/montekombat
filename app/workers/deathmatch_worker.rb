class DeathmatchWorker
  include Sidekiq::Worker

  def perform(tournament_id)
    @tournament = Tournament.find(tournament_id)
    # if correct_date?(@tournament.start_date)
      if @tournament.empty_slots.zero?
        number_of_teams = @tournament.number_of_teams
        # rounds_number = Math.log2(number_of_teams).ceil

        if @tournament.rounds.any?
          # calculate number of teams that will take part in generated round
          #
          round_number = @tournament.rounds.last.round_number + 1
        else
          round_number = 1
        end

        if need_prelims?(number_of_teams) && number_of_teams != 1
          # ------------------------------------------------------------------
          # Calculate number of prelims matches and teams
          number_of_prelims_matches = number_of_teams - (2**Math.log2(number_of_teams).floor)
          number_of_prelims_teams = number_of_prelims_matches * 2
          # ------------------------------------------------------------------
          # Take number_of_prelims_teams from teams in @tournament
          teams = @tournament.teams.first(number_of_prelims_teams)
          # additional_number_of_teams = number_of_teams - number_of_prelims_teams
          # promoted_teams = @tournament.teams.last(additional_number_of_teams)
        else
          number_of_prelims_teams = @tournament.teams.count
          teams = @tournament.teams
        end

        round = Round.create(round_number: round_number, tournament: @tournament)
        add_matches_to_round(number_of_prelims_teams, teams, round)
        @tournament.update_attributes(status: "started") unless @tournament.started?
      end
  end

  private

  def correct_date?(date)
    date.to_datetime == DateTime.now
  end

  def need_prelims?(number_of_teams)
    Math.log2(number_of_teams) != Math.log2(number_of_teams).floor.to_f
  end

  def add_matches_to_round(number_of_teams, teams, round)
    0.step(number_of_teams - 2, 2) do |index|
      match = Match.create(game: @tournament.game,
                           team_1: teams[index],
                           team_2: teams[index + 1],
                           match_type: "competetive",
                           creator_id: @tournament.creator.id,
                           date: @tournament.start_date)
      round.matches << match
    end
  end
end
