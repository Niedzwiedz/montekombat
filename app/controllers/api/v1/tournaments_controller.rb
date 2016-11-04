module Api
  module V1
    class TournamentsController < ApplicationController
      def index
        render json: TournamentsRepresenter.new(Tournament.all)
      end

      def new
        @tournament = Tournament.new
        @tournament.teams.build
      end

      def show
        render json: TournamentRepresenter.new(tournament)
      end

      def edit
        render json: TournamentRepresenter.new(tournament)
      end

      def create
        @tournament = InitializeTournament.call(tournament_params, teams_params)
        if @tournament.instance_of? Tournament
          if @tournament.deathmatch?
            DeathmatchWorker.perform_in(time(@tournament.start_date).minutes.from_now, @tournament.id)
          end
          render json: TournamentRepresenter.new(@tournament)
        else
          render json: { error: @tournament }
        end
      end

      def update
        unless tournament.ended?
          if tournament.update(edit_params(tournament))
            render json: TournamentRepresenter.new(tournament)
          end

        end
      end

      def destroy
        tournament.destroy if tournament.open?
        head :ok if tournament.open?
      end

      def types
        @types = Tournament.tournament_types.keys.to_a
        respond_to do |format|
          format.json { render json: @types }
        end
      end

      private

      def time(start_date)
        (start_date.to_datetime.to_i - Time.zone.now.to_datetime.to_i) / 60
      end

      def tournament
        @tournament ||= Tournament.find(params[:id])
      end

      def tournament_params
        params.require(:tournament).permit(:game_id, :creator_id, :title, :description,
                                           :tournament_type, :number_of_teams, :creator,
                                           :number_of_players_in_team, :start_date)
      end

      def team_params
        params.require(:team).permit(:name)
      end

      def teams_params
        params.require(:teams).permit!
      end

      def tournament_started_params
        params.require(:tournament).permit(:title, :description)
      end

      def edit_params(tournament)
        if tournament.open?
          tournament_params
        elsif tournament.started?
          tournament_started_params
        end
      end
    end
  end
end
