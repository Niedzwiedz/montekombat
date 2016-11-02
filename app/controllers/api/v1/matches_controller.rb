module Api
  module V1
    class MatchesController < ApplicationController
      # before_action :authenticate_user

      def index
        render json: MatchesRepresenter.new(Match.all)
      end

      def show
        render json: MatchRepresenter.new(match)
      end

      def edit
        render json: MatchRepresenter.new(match)
      end

      def create
        match = Match.create(match_params)
        render json: MatchRepresenter.new(match)
      end

      def update
        match.update_attributes(match_params)
        updated_match = UpdateMatch.call(match)
        render json: MatchRepresenter.new(updated_match)
      end

      # Additional actions

      def options
        statuses = Match.statuses.keys.to_a
        match_types = Match.match_types.keys.to_a
        render json: MatchesOptionsRepresenter.new(statuses, match_types)
      end

      private

      def match
        @match ||= Match.includes(:game, :team_1, :team_2).find(params[:id])
      end

      def match_params
        params_match = [:game, :team1, :team2, :status, :match_type, :points_for_team1, :points_for_team2] if match.friendly?
        params_match = [:points_for_team1, :points_for_team2, :status] if match.competetive?
        params.require(:match).permit(params_match)
      end
    end
  end
end
