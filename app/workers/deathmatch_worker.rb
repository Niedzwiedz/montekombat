class DeathmatchWorker
  include Sidekiq::Worker

  def perform(tournament_id)
    @tournament = Tournament.find(tournament_id)
    # if correct_date?(@tournament.start_date)
      if @tournament.empty_slots.zero?
        # rounds_number = Math.log2(number_of_teams).ceil
        round_number = round_number(@tournament.rounds)

        if need_prelims?(number_of_teams) && number_of_teams != 1
          teams = @tournament.teams.first(number_of_prelims_teams)
          # additional_number_of_teams = number_of_teams - number_of_prelims_teams
          # promoted_teams = @tournament.teams.last(additional_number_of_teams)
        else
          teams = []
          playing_teams_ids.each do |team_id|
            teams << Team.find(team_id)
          end
          number_of_prelims_teams = @tournament.teams.count
        end

        round = Round.create(round_number: round_number, tournament: @tournament)
        add_matches_to_round(number_of_prelims_teams, teams, round)
        @tournament.update_attributes(status: "started") unless @tournament.started?
      end
  end

  private

  def playing_teams_ids
    @tournament.playing_teams
  end

  def number_of_teams
    playing_teams_ids.count
  end

  def round_number(tournament_rounds)
    if tournament_rounds.any?
      tournament_rounds.last.round_number + 1
    else
      1
    end
  end

  def number_of_prelims_matches
    number_of_teams - (2**Math.log2(number_of_teams).floor)
  end

  def number_of_prelims_teams
    number_of_prelims_matches * 2
  end

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
